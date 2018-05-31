#!/usr/bin/env Rscript

# set working directory - this is where plots and other results files will be saved
setwd("/mnt/s3/results/")

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

# Create boxplots
pdf("wheat_seeds_boxplots.pdf", width=6, height=6)
featurePlot(x = morphTrain,
            y = varietyTrain,
            plot = "box",
            ## Pass in options to bwplot()
            scales = list(y = list(relation="free"),
                          x = list(rot = 90)),
            layout = c(3,3))
dev.off()

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

# Check for skewness using density plot
pdf("wheat_seeds_density_plot.pdf", width=6, height=6)
featurePlot(x = morphTrain,
            y = varietyTrain,
            plot = "density",
            ## Pass in options to xyplot() to
            ## make it prettier
            scales = list(x = list(relation="free"),
                          y = list(relation="free")),
            adjust = 1.5,
            pch = "|",
            layout = c(3, 3),
            auto.key = list(columns = 3))
dev.off()


# CLASSIFICATION USING kNN

# Create a ‘grid’ of values of k for evaluation:
tuneParam <- data.frame(k=seq(1,50,2))

# Generate a list of seeds for reproducibility based on grid size
set.seed(42)
seeds <- vector(mode = "list", length = 101)
for(i in 1:100) seeds[[i]] <- sample.int(1000, length(tuneParam$k))
seeds[[101]] <- sample.int(1000,1)

# Set training parameters
#train_ctrl <- trainControl(method="repeatedcv",
#                           number = 10,
#                           repeats = 10,
#                           preProcOptions=list(cutoff=0.75),
#                           seeds = seeds)

train_ctrl <- trainControl(method="repeatedcv",
                           number = 10,
                           repeats = 10,
                           seeds = seeds)


# Run training to find optimum value of k
(knnFit <- train(morphTrain, varietyTrain,
                method="knn",
                preProcess = c("center", "scale"),
                tuneGrid=tuneParam,
                trControl=train_ctrl))

# Plot cross validation accuracy as a function of k
pdf("wheat_seeds_knn_cross-validation.pdf", width=6, height=4)
plot(knnFit)
dev.off()

# Predict the class (wheat variety) of the observations in the test set.
test_pred <- predict(knnFit, morphTest)
confusionMatrix(test_pred, varietyTest)

