resource "aws_security_group" "es" {
  name        = "sg_private_${local.es_name}"
  vpc_id      = data.aws_vpc.mvp-es.id
  description = "Allow https inbound from same VPC"

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [ data.aws_vpc.mvp-es.cidr_block ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rdp" {
  name        = "sg_rdp_public_${var.suffix}"
  vpc_id      = data.aws_vpc.mvp-es.id
  description = "Allow RDP inbound traffic from internet"

  ingress {
    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "ssh" {
  name        = "sg_ssh_public_${var.suffix}"
  vpc_id      = data.aws_vpc.mvp-es.id
  description = "Allow RDP inbound traffic from internet"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
