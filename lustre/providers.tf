provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
  profile = var.aws_profle_name
}

terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    bucket         = "cs1u.mvp.demo.tfstate"
    key            = "demo/lustre.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    acl            = "bucket-owner-full-control"
  }
}
