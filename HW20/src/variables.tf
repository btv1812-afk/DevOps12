variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string

}

variable "list_of_open_ports" {
  description = "List of YCP ports to open"
  type        = list(number)
}

variable "aws_region" {
  description = "Region for S3"
  type        = string
  default     = "eu-central-1"

}