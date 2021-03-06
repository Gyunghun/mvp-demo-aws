#############################################################################
# These values are placeholders. You should set and use the values of '../project.tfvars'
variable "project_name" {
  default = "mvp-demo"
}

variable "region" {
  default = "ap-northeast-2"
}

variable "profile" {
  default = "cs1u"
}

# just for compatability with s3 backend configuration file
variable "bucket" { 
}
#############################################################################

variable "ec2_keypair" {
  default = "mvp_demo"
}

locals {
  vpc_name = "${var.project_name}"
  es_name  = "${var.project_name}"
}
