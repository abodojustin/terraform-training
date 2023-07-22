provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAZVR5NZ5MZMTNFJ4T"
  secret_key = "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"
}

resource "aws_instance" "myec2" {
  ami           = "ami-086b3558ad8a55090"
  instance_type = "t2.micro"
  key_name      = "devops-francis"
  tags = {
    Name = "ec2-francis"
  }
  root_block_device {
    delete_on_termination = true
  }
}