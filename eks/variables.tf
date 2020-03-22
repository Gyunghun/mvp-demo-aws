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
  vpc_name = "${var.project_name}-${var.suffix}"
  eks_name = "${var.project_name}-${var.suffix}"
  ec2_keypair = var.project_name

  desired_capacity = 3
  max_capacity     = 10
  min_capacity     = 3
  instance_type    = "m5.2xlarge"
  worker_disk_size = 200
}
