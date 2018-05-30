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

<div class="figure" style="text-align: center">
<img src="images/aws_menu_RH.png" alt="AWS menu in Federation Console." width="30%" />
<p class="caption">(\#fig:storageAWSmenu)AWS menu in Federation Console.</p>
</div>


<div class="figure" style="text-align: center">
<img src="images/IAM_users.png" alt="IAM users" width="100%" />
<p class="caption">(\#fig:iamUsers)IAM users</p>
</div>


## Command line

### AWS command line tools
