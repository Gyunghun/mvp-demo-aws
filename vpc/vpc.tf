module "vpc-mvp" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = "10.20.0.0/16"

  azs              = [ "ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c" ]
  public_subnets   = [ "10.20.101.0/24",  "10.20.102.0/24",  "10.20.103.0/24" ]
  private_subnets  = [ "10.20.11.0/24",   "10.20.12.0/24",   "10.20.13.0/24", //for eks     [0~2]
                       "10.20.21.0/24",   "10.20.22.0/24",   "10.20.23.0/24", //for luster  [3~5]
                       "10.20.31.0/24",   "10.20.32.0/24",   "10.20.33.0/24", //for general [6~8]
                      ]
  database_subnets = [ "10.20.51.0/24",   "10.20.52.0/24",   "10.20.53.0/24" ]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_vpn_gateway     = true
  
  enable_dns_hostnames   = true
  enable_dns_support     = true

  enable_s3_endpoint     = true

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
    "kubernetes.io/cluster/${local.eks_name}" = "shared"
    "kubernetes.io/role/internal-elb"         = "1"
    "Tier"                                    = "database"
  }
}

output "vpc_name" {
  value = local.vpc_name
}
output "eks_name" {
  value = local.eks_name
}