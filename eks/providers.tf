provider "aws" {
  version = "~> 2.0"
  region  = var.region
  profile = var.aws_profle_name
}

terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    bucket         = "cs1u.mvp.demo.tfstate"
    key            = "demo/eks.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "cs1u_mvp_demo_tfstate_lock"
    acl            = "bucket-owner-full-control"
  }
}
