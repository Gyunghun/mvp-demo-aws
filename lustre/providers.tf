provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
  profile = var.profile
}

terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    key            = "project/lustre.jp.tfstate"
    encrypt        = true
    acl            = "bucket-owner-full-control"
  }
}
