variable "region" {
  default = "ap-northeast-2"
}

variable "aws_profle_name" {
  default = "default"
}

variable "project_name" {
  default = "mvp-demo"
}

variable "suffix" {
  default = "tp2"
}

locals {
  vpc_name = "${var.project_name}-${var.suffix}"
  efs_name = "${var.project_name}-${var.suffix}"
}
