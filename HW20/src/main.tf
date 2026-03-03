terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-danit-kate"
    key    = "prod"
    region = "eu-central-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

module "sg_nginx" {
  source             = "./modules/security_groups"
  vpc_id             = var.vpc_id
  list_of_open_ports = var.list_of_open_ports

}