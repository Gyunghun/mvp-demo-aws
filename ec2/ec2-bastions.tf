data "aws_vpc" "mvp-ec2" {
  tags = {
    Name = local.vpc_name
  }
}

data "aws_subnet" "bastion" {
  vpc_id = data.aws_vpc.mvp-ec2.id
  tags = {
    Tier = "public"
  }
  availability_zone = "ap-northeast-2a"
}

resource "aws_key_pair" "deployer" {
  key_name   = var.project_name
  public_key = local.ec2_public_key
}

##### Windows 2019 for Bastion Server
data "aws_ami" "win2019-base" {
  most_recent = true
  owners      = ["801119661308"] # amazon
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "win2019" {
  ami           = data.aws_ami.win2019-base.id
  instance_type = "t3.medium"
  key_name      = aws_key_pair.deployer.key_name
  subnet_id     = data.aws_subnet.bastion.id
  vpc_security_group_ids = [
    aws_security_group.rdp.id,
  ]
  count = 1
  tags = {
    Name        = "${local.ec2_prefix}_win2019_bastion"
    Purpose     = "bastion"
    Terraform   = "true"
    Environment = "dev"
  }
}

##### UBUNTU for Bastion Server
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name      = aws_key_pair.deployer.key_name
  subnet_id     = data.aws_subnet.bastion.id
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
  ]
  count = 1
  tags = {
    Name        = "${local.ec2_prefix}_ubuntu_bastion"
    Purpose     = "bastion"
    Terraform   = "true"
    Environment = "dev"
  }
}

output "windows_bastion_ip" {
  description = "Public Ip of Windows Bastion Server"
  value       = aws_instance.win2019[0].public_ip
}

output "windows_bastion_ec2_id" {
  description = "EC2 ID of Windows Bastion Server"
  value       = aws_instance.win2019[0].id
}

output "linux_bastion_ip" {
  description = "Public Ip of Ubuntu Bastion Server"
  value       = aws_instance.ubuntu[0].public_ip
}
