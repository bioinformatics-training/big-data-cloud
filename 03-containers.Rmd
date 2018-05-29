---
output: html_document
editor_options: 
  chunk_output_type: console
---
# Images and containers {#containers}

<!-- introduction to containers -->

## Definitions

**Docker images** are the basis of containers. An Image is an ordered collection of root filesystem changes and the corresponding execution parameters for use within a container runtime. An image typically contains a union of layered filesystems stacked on top of each other. An image does not have state and it never changes.

A **container** is a runtime instance of a docker image.

A Docker container consists of

* A Docker image
* An execution environment
* A standard set of instructions

The concept is borrowed from Shipping Containers, which define a standard to ship goods globally. Docker defines a standard to ship software.

## Images on RosettaHUB

RosettaHUB provides two types of [images](https://docs.rosettahub.com/display/management/Image):

* **Managed images:** These are images that are created and maintained by RosettaHUB or images that are derived from these images. RosettaHUB currently provides two managed images (CPU-Docker RH Workbench and GPU-Nvidia-Docker RH Workbench) which are equipped with a range of tools (Jupyter, Zeppelin, RStudio and RosettaHUB workbench) to facilitate data science and have a user friendly desktop environment.

* **Semi-managed images:** These are images that map AMIs on AWS that are not derived from RosettaHUB images. Semi-managed images allow users to easily launch a machine from the RosettaHUB web console using their RosettaHUB keys. Access to the instances is managed by RosettaHUB, ie RosettaHUB generates and saves the private keys associated with the machine and allows you to retrieve any time the credentials to connect your machine using RDP for Windows instances or Ssh for Linux instances.


## Launch a container
