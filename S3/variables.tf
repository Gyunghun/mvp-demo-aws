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
  default = "tp2"
}

locals {
  bucket_name = "${var.project_name}-${var.suffix}"
  log_bucket_name = "${var.project_name}-${var.suffix}-logs"
}
