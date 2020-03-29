locals {
  vpc_name = "${var.project_name}"
  eks_name = "${var.project_name}"
}

variable "project_name" {
  default = "mvp-demo"
}

variable "region" {
  default = "ap-northeast-2"
}

variable "profile" {
  default = "cs1u"
}

variable "bucket" { } // just for compatability with s3 backend configuration file