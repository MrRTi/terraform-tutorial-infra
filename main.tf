terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.38"
    }
  }

  required_version = ">= 0.15.3"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


locals {
  # FEDORA-COREOS
  instance_ami = "ami-09e2e5104f310ffb5"
}

resource "aws_instance" "app_server" {
  ami           = local.instance_ami
  instance_type = "t2.micro"

  tags = {
    Name = "Study AppServer"
  }

  vpc_security_group_ids = [
    module.ec2_sg.security_group_id
  ]
}

data "aws_vpc" "default" {
  default = true
}

module "ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ec2_sg"
  description = "Security group for ec2_sg"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

