data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_vpc" "mvp-es" {
  tags = {
    Name = local.vpc_name
  }
}

data "aws_subnet" "mvp-es" {
  vpc_id = data.aws_vpc.mvp-es.id
  tags = {
    Tier = "private"
  }
  availability_zone = "ap-northeast-2a"
}

resource "aws_elasticsearch_domain" "mvp-es" {
  domain_name           = local.es_name
  elasticsearch_version = "7.1"

  cluster_config {
    instance_type = "t2.medium.elasticsearch"
    instance_count = 2
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 15
  }

  vpc_options {
    subnet_ids = [ data.aws_subnet.mvp-es.id ]
    security_group_ids = [ aws_security_group.es.id ]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${local.es_name}/*"
        }
    ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = {
    Domain = "mvp-demo"
  }

}

output "ElasticSearch_Endpoint" {
  description = "Elasticsearch Enpoint"
  value = aws_elasticsearch_domain.mvp-es.endpoint
}

output "Kibana_Endpoint" {
  description = "Kibana Enpoint"
  value = aws_elasticsearch_domain.mvp-es.kibana_endpoint
}