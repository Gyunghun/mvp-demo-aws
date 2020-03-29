data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

data "aws_vpc" "mvp-eks" {
  tags = {
    Name = local.vpc_name
  }
}

data "aws_subnet_ids" "mvp-eks" {
  vpc_id = data.aws_vpc.mvp-eks.id
}
data "aws_subnet" "mvp-eks" {
  for_each = data.aws_subnet_ids.mvp-eks.ids
  id       = each.value
}

data "aws_subnet_ids" "mvp-eks-pub" {
  vpc_id = data.aws_vpc.mvp-eks.id
  tags = {
    Tier = "public"
  }
}
data "aws_subnet" "mvp-eks-pub" {
  for_each = data.aws_subnet_ids.mvp-eks-pub.ids
  id       = each.value
}

resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = data.aws_vpc.mvp-eks.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = data.aws_vpc.mvp-eks.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

data "aws_eks_cluster" "mvp-eks" {
  name = module.mvp-eks.cluster_id
}

data "aws_eks_cluster_auth" "mvp-eks" {
  name = module.mvp-eks.cluster_id
}

module "mvp-eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_version = "1.15"
  cluster_name    = local.eks_name
  vpc_id          = data.aws_vpc.mvp-eks.id
  subnets         = [for s in data.aws_subnet.mvp-eks : s.id]

  write_kubeconfig = true

  # Modify these to control cluster access
  cluster_endpoint_private_access      = "true"
  cluster_endpoint_public_access       = "true"
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0", ] #to limit access later

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = local.worker_disk_size
  }

  tags = {
    Environment = "dev"
  }

  node_groups = {
    mvp_nodes1 = {
      name                            = "${local.eks_name}-nodes"
      subnets                         = [for s in data.aws_subnet.mvp-eks-pub : s.id]
      desired_capacity                = local.desired_capacity
      max_capacity                    = local.max_capacity
      min_capacity                    = local.min_capacity
      instance_type                   = local.instance_type
      cluster_endpoint_private_access = true
      additional_security_group_ids   = [aws_security_group.worker_group_mgmt_one.id]
      k8s_labels = {
        Environment = "dev"
      }
      additional_tags = {
        ExtraTag = "mvp-demo"
      }
      remote_access = {
        ec2_ssh_key = local.ec2_keypair
      }
    }
  }

  map_roles    = var.map_roles
  map_users    = var.map_users
  map_accounts = var.map_accounts
}

data "aws_subnet_ids" "mvp-eks-priv" {
  vpc_id = data.aws_vpc.mvp-eks.id
  tags = {
    Tier = "private"
  }
}
data "aws_subnet" "mvp-eks-priv" {
  for_each = data.aws_subnet_ids.mvp-eks-priv.ids
  id       = each.value
}

provider "kubernetes" {
  alias                  = "skcc-aws-demo"
  host                   = data.aws_eks_cluster.mvp-eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.mvp-eks.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.mvp-eks.token
  # load_config_file       = true
  # config_path            = "kubeconfig_${local.eks_name}"
  version                = "~> 1.11"
}
