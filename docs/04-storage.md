# Storage {#storage}
In this chapter we will show you how to use the Amazon Web Services (AWS) Simple Storage Service (S3) ([https://aws.amazon.com/documentation/s3/](https://aws.amazon.com/documentation/s3/)).

## Create an S3 bucket
On S3, objects (data and their metadata) are stored in buckets. RosettaHUB calls these buckets **Simple Storage Drives** and provides a default bucket for each user.

<div class="figure" style="text-align: center">
<img src="images/storage_simple_storage_drives_section.png" alt="Simple storage drive section on Federation console" width="50%" />
<p class="caption">(\#fig:storageS3DriveSection)Simple storage drive section on Federation console</p>
</div>

Let's create a new bucket (simple storage drive) to use on this course. Go to the simple storage drive section on the Federation console and click create.
<div class="figure" style="text-align: center">
<img src="images/create_s3_storage.png" alt="Create S3 storage dialog box" width="80%" />
<p class="caption">(\#fig:storageCreateS3Storage)Create S3 storage dialog box</p>
</div>

Specify a **Label** and **Bucket**. Accept defaults for all other settings. The **Bucket** name must be globally unique ([https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html](https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html)), so here we have combined our username (bioinfo1.cam) with the RosettaHUB domain name:

**Label**: *course*

**Bucket**: *com-rosettahub-course-bioinfo1.cam*


<div class="figure" style="text-align: center">
<img src="images/create_s3_storage_form_completed.png" alt="Set Label and Bucket names" width="80%" />
<p class="caption">(\#fig:storageCreateS3StorageCompletedForm)Set Label and Bucket names</p>
</div>

Once your new simple storage drive has been created, it will be listed alongside your default storage drive.
<div class="figure" style="text-align: center">
<img src="images/simple_storage_drives_incl_course.png" alt="New S3 bucket has been added to list of simple storage drives." width="80%" />
<p class="caption">(\#fig:storageS3course)New S3 bucket has been added to list of simple storage drives.</p>
</div>

Left clicking on the new bucket (simple storage drive) will take you to the AWS management console. Try uploading a file.
<div class="figure" style="text-align: center">
<img src="images/s3_bucket_web_interface.png" alt="S3 bucket web interface." width="100%" />
<p class="caption">(\#fig:storageS3BucketWebInterface)S3 bucket web interface.</p>
</div>

## Identity and Access Management (IAM)
AWS Identity and Access Management (IAM) enables you to control access to AWS services and resources. IAM users are useful if you want to give access to your account to other users or groups but with a limit on what they can do on your account. This allows you for example to give access to AWS to users who do not have an AWS account or to give access to a specific S3 buckets to a group of users. 

We will use IAM to manage access to our new S3 bucket (simple storage drive). In the Federation Console, expand the AWS menu on the left hand panel, and select IAM users.
<div class="figure" style="text-align: center">
<img src="images/aws_menu_RH.png" alt="AWS menu in Federation Console." width="30%" />
<p class="caption">(\#fig:storageAWSmenu)AWS menu in Federation Console.</p>
</div>

This will display the following table:
<div class="figure" style="text-align: center">
<img src="images/IAM_users.png" alt="IAM users" width="100%" />
<p class="caption">(\#fig:iamUsers)IAM users</p>
</div>

You will see that an IAM user has been created for you automatically. This default IAM user has access to all of your AWS resources. We want to create an IAM user that can be used to share your new S3 bucket, but does not have access to any of your other resources. Click on the **Create** button to bring up the following dialog box:
<div class="figure" style="text-align: center">
<img src="images/create_iam_user.png" alt="Create IAM user dialog." width="80%" />
<p class="caption">(\#fig:createIAMuser)Create IAM user dialog.</p>
</div>

Enter an **Iam User Name** and **Label**. The **Signin Url** can be left blank and the **Default Region** does not need to be changed from **eu-west-1**. The default policy is **AdministratorAccess**, which is inappropriate for our new IAM user. Selecting **AmazonS3FullAccess** brings up a more restrictive policy, where the new IAM user can only access S3 services:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
```

However, this is still too permissive. We want to restrict our new IAM user to the S3 bucket we've created for the course. This can be achieved by specifying the following policy:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": ["arn:aws:s3:::com-rosettahub-course-bioinfo1.cam/*"]
    }
  ]
}
```

The completed form should look something like this:
<div class="figure" style="text-align: center">
<img src="images/create_iam_user_completed_form.png" alt="Create IAM user dialog. Auto generated policy replaced with manually edited version." width="80%" />
<p class="caption">(\#fig:createIAMuserCompletedForm)Create IAM user dialog. Auto generated policy replaced with manually edited version.</p>
</div>



## AWS command line tools
Earlier we saw how we could upload files to our S3 bucket using the web interface. Amazon AWS also provide a Command Line Interface (CLI) to Amazon S3. The CLI can be used to script and automate file transfers.

### Installation of AWS CLI
Instructions for installing the AWS CLI can be found here: [https://docs.aws.amazon.com/cli/latest/userguide/installing.html](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)

The AWS CLI has already been installed on the classroom workstations. Verify that is has been installed correctly by running:
```
aws --version
```

### Configuration of the AWS CLI
Configuration of the AWS CLI requires the **Access Key ID** and the **Secret access key** of an IAM user. From the RosettaHUB Federation Console go to the **IAM Users** panel. Copy the security credentials for the IAM user we created earlier; they should look something like this:

* Access key ID: AKIAIOSFODNN7EXAMPLE
* Secret Access Key: UYPg0R42LkqfVbp2YKre/Rz6FbepX/EXAMPLEKEY

Run the configuration tool:
```
aws configure
```

Enter security credentials of IAM user. Default region name should be set to eu-west-1, and default output format to json.
```
AWS Access Key ID [****************JQKA]: AKIAJQWONQOOSXXXXXXX
AWS Secret Access Key [****************APTR]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [eu-west-1]: 
Default output format [json]: 
```

We are now ready to upload files to the S3 bucket we created for the course. Let's copy the data subdirectory of Course_Materials to our new S3 bucket.
```
aws s3 cp --recursive ~/Course_Materials/data s3://com-rosettahub-course-bioinfo1.cam/data/
```

Go to the web interface for the bucket and you will see the data directory and its contents.

