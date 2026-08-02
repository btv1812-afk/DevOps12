variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "eu-central-1"
  
}

variable "project_name" {
    description = "The name of the project"
    type        = string
    # default     = "my_project"
  
}

variable "environment" {
    description = "The environment for the deployment (e.g., dev, staging, prod)"
    type        = string
    #default     = "dev"
  
}

variable "aws_profile" {
    description = "The AWS profile to use for authentication"
    type        = string
    default     = "default"
  
}

variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
  
}