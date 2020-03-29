module "vpc-mvp-jpn" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = "10.30.0.0/16"

  azs              = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  private_subnets  = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
  public_subnets   = ["10.30.101.0/24", "10.30.102.0/24", "10.30.103.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_vpn_gateway     = true
  
  enable_dns_hostnames   = true
  enable_dns_support     = true

  tags = {
    Terraform                                 = "true"
    Environment                               = "dev"
  }

  public_subnet_tags = {
    "Tier"                                    = "public"
  }

  private_subnet_tags = {
    "Tier"                                    = "private"
  }

  database_subnet_tags = {
    "Tier"                                    = "database"
  }
}


output "vpc_name" {
  value =  module.vpc-mvp-jpn.name
}
