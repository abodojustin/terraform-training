provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAZVR5NZ5M6ITWJWES"
  secret_key = "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"
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

    sg_name = "sg-prod-francis"

}