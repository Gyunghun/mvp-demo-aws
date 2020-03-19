data "aws_subnet" "bastion" {
  vpc_id = data.aws_vpc.mvp-es.id
  tags = {
    Tier = "public"
  }
  availability_zone = "ap-northeast-2a"
}

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
  key_name      = var.ec2_keypair
  subnet_id     = data.aws_subnet.bastion.id
  vpc_security_group_ids = [
    aws_security_group.rdp.id,
  ]
  count = 1
  tags = {
    Purpose = "bastion"
    Name    = "${local.es-name}_win2019_bastion"
  }
}

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
  key_name      = var.ec2_keypair
  subnet_id     = data.aws_subnet.bastion.id
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
  ]
  count = 1
  tags = {
    Purpose = "bastion"
    Name    = "${local.es-name}_ubuntu_bastion_"
  }
}

output "windows_bastion_ip" {
  description = "Public Ip of Windows Bastion Server"
  value = aws_instance.win2019[0].public_ip
}

output "linux_bastion_ip" {
  description = "Public Ip of Ubuntu Bastion Server"
  value = aws_instance.ubuntu[0].public_ip
}