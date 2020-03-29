#############################################################################
# These values are placeholders. You should set and use the values of '../project.tfvars'
variable "project_name" {
  default = "mvp-demo"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "profile" {
  default = "cs1u"
}

# just for compatability with s3 backend configuration file
variable "bucket" { 
}
#############################################################################

resource "random_string" "suffix" {
  length  = 4
  min_lower = 1
  min_numeric = 1
  special = false
  upper = false
}

locals {
  vpc_name = var.project_name
  lustre_name = var.project_name
  s3_bucket_lustre = "${var.project_name}-${random_string.suffix.result}-lustre"
}
