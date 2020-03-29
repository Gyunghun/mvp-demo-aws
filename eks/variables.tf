#############################################################################
# These values are placeholders. You should set and use the values of '../project.tfvars'
variable "project_name" {
  default = "mvp-demo"
}

variable "region" {
  default = "ap-northeast-2"
}

variable "profile" {
  default = "cs1u"
}

# just for compatability with s3 backend configuration file
variable "bucket" { 
}
#############################################################################

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "664311806486",
  ]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::664311806486:role/eks-basic-role"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:masters", "system:bootstrappers", "system:nodes"]
    }
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::664311806486:user/mgchang"
      username = "mgchang"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::664311806486:user/gyunghun1024"
      username = "gyunghun1024"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::664311806486:user/todend98"
      username = "todend98"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::664311806486:user/architect"
      username = "architect"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::664311806486:user/circleci"
      username = "circleci"
      groups   = ["system:masters"]
    }
  ]
}

locals {
  vpc_name = "${var.project_name}"
  eks_name = "${var.project_name}"
  ec2_keypair = var.project_name

  desired_capacity = 3
  max_capacity     = 10
  min_capacity     = 3
  instance_type    = "m5.2xlarge"
  worker_disk_size = 100
}
