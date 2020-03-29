# EFS File System with tags & lifecycle policy
resource "aws_efs_file_system" "mvp_demo" {
  # creation_token = "my-product"

  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
  }

  tags          = {
    Terraform = "true"
    Environment = "dev"
    Name = local.efs_name
  } 
}

data "aws_vpc" "mvp-efs" {
  tags = {
    Name = local.vpc_name
  }
}

data "aws_subnet_ids" "mvp-priv" {
  vpc_id = data.aws_vpc.mvp-efs.id
  tags = {
    Tier = "private"
  }
}

data "aws_subnet" "mvp-priv" {
  for_each = data.aws_subnet_ids.mvp-priv.ids
  id       = each.value
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}


resource "aws_efs_mount_target" "mvp-efs" {
  count = length([for s in data.aws_subnet.mvp-priv : s.id])
  file_system_id  = aws_efs_file_system.mvp_demo.id
  subnet_id = element( [for s in data.aws_subnet.mvp-priv : s.id], count.index )
  # security_groups = ["${aws_security_group.efs-sg.id}"]
}
