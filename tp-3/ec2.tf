provider "aws" {
  region     = "us-east-1"
#  access_key = "AKIA6L3GDSN4BTTB54HH"
#  secret_key = "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"
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instancetype
  key_name      = "test-francis"
  tags          = var.aws_common_tag
  root_block_device {
    delete_on_termination = true
  }
  vpc_security_group_ids = ["${aws_security_group.allow_http_https.id}"]
}

resource "aws_security_group" "allow_http_https" {
  name        = "francis-sg"
  description = "Allow http and https inbound traffic"

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
}