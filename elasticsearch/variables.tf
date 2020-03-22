variable "aws_profile_name" {
  default = "cs1u"
}

variable "region" {
  default = "ap-northeast-2"
}

variable "ec2_keypair" {
  default = "mvp_demo"
}

variable "project_name" {
  default = "mvp-demo"
}

variable "suffix" {
  default = "tp2"
}

locals {
  vpc_name = "${var.project_name}-${var.suffix}"
  es_name  = "${var.project_name}-${var.suffix}"
}
