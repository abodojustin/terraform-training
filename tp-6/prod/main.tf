provider "aws" {
  region     = "us-east-1"
  access_key = "PUT YOUR OWN"
  secret_key = "PUT YOUR OWN"
}

terraform {
  backend "s3" {
    bucket     = "terraform-backend-francis-devops"
    key        = "francis-prod-tfstate"
    region     = "us-east-1"
    access_key = "PUT YOUR OWN"
    secret_key = "PUT YOUR OWN"
  }
}

module "ec2" {
  source = "../modules/ec2module"

  instancetype = "t2.micro"
  aws_common_tag = {
    Name = "ec2-prod-francis"
  }

    sg_name = "francis-prod-sg"

}