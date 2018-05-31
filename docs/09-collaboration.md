# Collaboration {#collaboration}

## Introduction
In chapter \@ref(containers) we saw how RosettaHUB's managed images facilitate real time collaboration. We have also seen how AWS Identity and Access Management (IAM) can be used to share storage in a controlled and secure manner (chapter \@ref(storage)). In this chapter we will look at sharing images, formations and containers. 


## Sharing images
Sharing images is easy. Right click on the machine image you would like to share, and select **share** from the pop-up menu:
<div class="figure" style="text-align: center">
<img src="images/CARET_machine_image_context_menu.png" alt="Image context menu" width="70%" />
<p class="caption">(\#fig:caretImageContextMenu)Image context menu</p>
</div>

Enter the user name of the person with whom you would like to share the image:
<div class="figure" style="text-align: center">
<img src="images/share_image1.png" alt="Share image: add user" width="100%" />
<p class="caption">(\#fig:shareImage1)Share image: add user</p>
</div>

After clicking **share** the username will be added to the list of users with access to your image.
<div class="figure" style="text-align: center">
<img src="images/share_image2.png" alt="Share image: user added" width="100%" />
<p class="caption">(\#fig:shareImage2)Share image: user added</p>
</div>

This is the appearance of the icon for the image on the owners console (note the grey symbol denoting sharing):
<div class="figure" style="text-align: center">
<img src="images/shared_image_owners_console.png" alt="Appearance of shared image icon on the owners console." width="50%" />
<p class="caption">(\#fig:sharedImageOwnersConsole)Appearance of shared image icon on the owners console.</p>
</div>

Here is the icon for the same image on the console of a user who has been granted access:
<div class="figure" style="text-align: center">
<img src="images/shared_image_on_other_users_console.png" alt="Appearance of shared image on the other user's console." width="100%" />
<p class="caption">(\#fig:sharedImageOthersConsole)Appearance of shared image on the other user's console.</p>
</div>

Try sharing the CARET machine image you created with your neighbour.

## Sharing formations and containers
Formations and containers (sessions in RosettaHUB terminology) can be shared in the same way as images. Try sharing a formation or container with your neighbour.
