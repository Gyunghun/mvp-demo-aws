variable "region" {
  default = "ap-northeast-2"
}

variable "aws_profle_name" {
  default = "cs1u"
}

variable "project_name" {
  default = "mvp-demo"
}

variable "suffix" {
  default = "jpn"
}

locals {
  vpc_name = "${var.project_name}-${var.suffix}"
  eks_name = "${local.vpc_name}"
  lustre_name = "${var.project_name}-${var.suffix}"
  s3_bucket_lustre = "${var.project_name}-${var.suffix}-lustre"
}
