resource "random_string" "suffix" {
  length  = 3
  min_lower = 1
  min_numeric = 1
  special = false
  upper = false
}

variable "project_name" {
  default = "mvp-demo"
}

locals {
  vpc_name = "${var.project_name}-${random_string.suffix.result}"
  eks_name = "${var.project_name}-${random_string.suffix.result}"
}


variable "region" {
  default = "ap-northeast-2"
}

variable "aws_profle_name" {
  default = "default"
}


