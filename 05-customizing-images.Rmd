# Customizing images {#customizing-images}

## Introduction

We can customize any of the managed or semi-managed images provided on RosettaHUB, by installing additional software, adding data or making configuration changes. 


In Docker terminology, we add [layers](https://docs.docker.com/glossary/?term=layer) to the base image.

For some projects we do not want the overhead of a graphical user interface and do not require all of the tools provided by the managed



To create a derived managed image, users have to launch a RosettaHUB machine then create an image from that machine on RosettaHUB. Managed images are configured with Docker containers. Docker containers contain applications for data science such as Pyhton, R, Rstudio, Scala, Sql and notebooks such as Jupyter and Zeppelin.

We can create derived images from any of these baseline images.
