resource "aws_fsx_lustre_file_system" "mvp-demo" {
  storage_capacity = 1200
  subnet_ids       = [module.vpc-mvp-jpn.private_subnets[0]]
  import_path      = "s3://${aws_s3_bucket.mvp_demo_s3.bucket}"
  imported_file_chunk_size = 2048
  tags          = {
    Terraform = "true"
    Environment = "dev"
    Name = local.lustre_name
  } 
}

resource "aws_s3_bucket" "mvp_demo_s3" {
  bucket = local.s3_bucket_lustre
  acl    = "private"
  tags   = {
    Name = "Terraform"
    Environment = "Dev"
  }
}


output "lustre_name" {
  value =  aws_fsx_lustre_file_system.mvp-demo.dns_name
}

