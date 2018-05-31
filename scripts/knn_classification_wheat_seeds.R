#!/usr/bin/env Rscript

# e-mail alert settings
emailSubjectSuccess <- "JOB COMPLETED: knn_classification_wheat_seeds.R"
emailSubjectFailure <- "JOB FAILED: knn_classification_wheat_seeds.R"
emailTo <- "mw283@cam.ac.uk"
emailFrom <- "CARET Bioinfo1"
emailMessageSuccess <- "Execution of script knn_classification_wheat_seeds.R has finished."
emailMessageFailure <- "Execution of script knn_classification_wheat_seeds.R has failed"

# output settings
outputDirectory <- "/mnt/s3/results/"
resultsFile <- "results.txt"

# function for sending e-mail alerts
sendAlertEmail <- function(subject, to, from, msg){
  mailfile <- "/tmp/email_alert.txt"
  write(paste("Subject:", subject, sep=" "), mailfile, append=FALSE)
  write(paste("To:", to, sep=" "), mailfile, append=TRUE)
  write(paste("From:", from, sep=" "), mailfile, append=TRUE)
  write("", mailfile, append=TRUE)
  write(msg, mailfile, append=TRUE)
  system(paste("cat", mailfile, "| ssmtp", emailTo, sep=" "))
  unlink("/tmp/email_alert.txt")
}

tryCatch(
  {
    # set working directory - this is where plots and other results files will be saved
    setwd(outputDirectory)

    # load libraries
    library(caret)
    library(RColorBrewer)
    library(doMC)
    library(corrplot)

    # prepare for parallel processing
    registerDoMC()

    # Load data
    load("/mnt/s3/data/wheat_seeds/wheat_seeds.Rda")

    # Partition data
    set.seed(42)
    trainIndex <- createDataPartition(y=variety, times=1, p=0.7, list=F)
    varietyTrain <- variety[trainIndex]
    morphTrain <- morphometrics[trainIndex,]
    varietyTest <- variety[-trainIndex]
    morphTest <- morphometrics[-trainIndex,]
    summary(varietyTrain)
    summary(varietyTest)

    # Inspect training data
    summary(morphTrain)

    # Does training data contain zero and near-zero predictors?
    (nzv <- nearZeroVar(morphTrain, saveMetrics=T))

    # Examine pairwise correlations between predictors
    corMat <- cor(morphTrain)

    # Create correlation plot
    pdf("wheat_seeds_correlation_plot.pdf", width=6, height=6)
    corrplot(corMat, order="hclust", tl.cex=1)
    dev.off()

    # Identify highly correlated variables
    highCorr <- findCorrelation(corMat, cutoff=0.75)
    length(highCorr)
    names(morphTrain)[highCorr]

    # CLASSIFICATION USING kNN

    # Create a ‘grid’ of values of k for evaluation:
    tuneParam <- data.frame(k=seq(1,50,2))

    # Generate a list of seeds for reproducibility based on grid size
    set.seed(42)
    seeds <- vector(mode = "list", length = 101)
    for(i in 1:100) seeds[[i]] <- sample.int(1000, length(tuneParam$k))
    seeds[[101]] <- sample.int(1000,1)

    # Set training parameters
    train_ctrl <- trainControl(method="repeatedcv",
                               number = 10,
                               repeats = 10,
                               seeds = seeds)


    # Run training to find optimum value of k
    knnFit <- train(morphTrain, varietyTrain,
                     method="knn",
                     preProcess = c("center", "scale"),
                     tuneGrid=tuneParam,
                     trControl=train_ctrl)

    # Predict the class (wheat variety) of the observations in the test set.
    test_pred <- predict(knnFit, morphTest)
    confMat <- confusionMatrix(test_pred, varietyTest)

    # Send e-mail notification that script execution is complete
    #emailSubject, emailTo, emailFrom, emailMessage
    sendAlertEmail(emailSubjectSuccess, emailTo, emailFrom, emailMessageSuccess)
  },
  error=function(err) {
    message(err)
    sendAlertEmail(emailSubjectFailure, emailTo, emailFrom, paste(emailMessageFailure, "\n\n", err, sep=""))
  }
)

write("Script: knn_classification_wheat_seeds.R", resultsFile, append=F)
write(paste("Date:", date(), sep=" "), resultsFile, append=T)
write("", resultsFile, append = T)

sink(resultsFile, append=TRUE)
cat("Class sizes in training set:\n")
summary(varietyTrain)
cat("\nClass sizes in test set:\n")
summary(varietyTest)
cat("\nCross-validation:\n")
knnFit
confMat
sink()
