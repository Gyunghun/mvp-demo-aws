provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-2"
  profile = "cs1u"
}

# DynamoDB : 요구사항은 LockID의 hash_key만 있으면 된다.
resource "aws_dynamodb_table" "mvp_tfstate_lock" {
  name = "cs1u_mvp_demo_tfstate_lock"
  read_capacity = 5
  write_capacity = 5
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


# S3 : 특별한 요구사항은 없다, 저장만 가능하면 됨, 여기는 s3 자체의 엑세스 기록을 위해 log bucket을 추가한다.
resource "aws_s3_bucket" "mvp_tfstate" {
  bucket = "cs1u.mvp.demo.tfstate"
  acl    = "private"
  tags   = {
    Name = "Terraform"
    Environment = "Dev"
  }

  versioning {
    enabled = true
  }
  logging {
    target_bucket = aws_s3_bucket.s3_logs.id
    target_prefix = "tfaccesslogs/"
  }
  lifecycle {
    prevent_destroy = false
  }
}


# s3 log용 bucket 생성
resource "aws_s3_bucket" "s3_logs" {
  bucket = "cs1u.mvp.demo.logs"
  acl    = "log-delivery-write"
}
