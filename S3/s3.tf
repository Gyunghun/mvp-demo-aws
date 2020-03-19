# S3 : 특별한 요구사항은 없다, 저장만 가능하면 됨, 여기는 s3 자체의 엑세스 기록을 위해 log bucket을 추가한다.
resource "aws_s3_bucket" "mvp_demo_s3" {
  bucket = local.bucket_name
  acl    = "private"
  tags   = {
    Name = "Terraform"
    Environment = "Dev"
  }

  versioning {
    enabled = true
  }
  logging {
    target_bucket = aws_s3_bucket.mvp_demo_logs.id
    target_prefix = "tfaccesslogs/"
  }
  lifecycle {
    prevent_destroy = false
  }
}

# s3 log용 bucket 생성
resource "aws_s3_bucket" "mvp_demo_logs" {
  bucket = local.log_bucket_name
  acl    = "log-delivery-write"
}
