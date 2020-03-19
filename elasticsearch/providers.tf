provider "aws" {
  version = "~> 2.0"
  region  = var.region
  profile = var.aws_profile_name
}

terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    bucket         = "cs1u.mvp.demo.tfstate"
    key            = "demo/elasticsearch.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    acl            = "bucket-owner-full-control"
  }
}
