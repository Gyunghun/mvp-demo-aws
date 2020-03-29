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

resource "random_string" "suffix" {
  length  = 4
  min_lower = 1
  min_numeric = 1
  special = false
  upper = false
}

locals {
  bucket_name = "${var.project_name}-${random_string.suffix.result}"
  log_bucket_name = "${var.project_name}-${random_string.suffix.result}-logs"
}
