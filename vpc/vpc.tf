module "vpc-mvp" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = "10.20.0.0/16"

  azs                 = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  public_subnets      = ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]
  private_subnets     = ["10.20.11.0/24", "10.20.12.0/24", "10.20.13.0/24"] //eks
  database_subnets    = ["10.20.21.0/24", "10.20.22.0/24", "10.20.23.0/24"] //tbd
  elasticache_subnets = ["10.20.31.0/24", "10.20.32.0/24", "10.20.33.0/24"] //lustre
  redshift_subnets    = ["10.20.41.0/24", "10.20.42.0/24", "10.20.43.0/24"] //tbd 
  intra_subnets       = ["10.20.51.0/24", "10.20.52.0/24", "10.20.53.0/24"] //tbd

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_vpn_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_s3_endpoint               = true
  enable_efs_endpoint              = true
  efs_endpoint_private_dns_enabled = true
  efs_endpoint_security_group_ids  = [data.aws_security_group.default.id]
  enable_ssm_endpoint              = true
  ssm_endpoint_private_dns_enabled = true
  ssm_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  tags = {
    "kubernetes.io/cluster/${local.eks_name}" = "shared",
    Terraform                                 = "true"
    Environment                               = "dev"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_name}" = "shared"
    "kubernetes.io/role/elb"                  = "1"
    "Tier"                                    = "public"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_name}" = "shared"
    "kubernetes.io/role/internal-elb"         = "1"
    "Tier"                                    = "private"
  }

  database_subnet_tags = {
    "Tier" = "database"
  }

  elasticache_subnet_tags = {
    "Tier" = "elasticache"
  }

  redshift_subnet_tags = {
    "Tier" = "redshift"
  }

  intra_subnet_tags = {
    "Tier" = "intra"
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc-mvp.vpc_id
}

output "vpc_name" {
  value = local.vpc_name
}
output "eks_name" {
  value = local.eks_name
}
