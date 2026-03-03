variable "vpc_cidr" {
    description = "Cidr for VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_region" {
    description = "Region for VPC"
    type = string
    default = "eu-central-1"
}
variable "public_subnet_cidr" {
    description = "Public subnet subnet"
    type = string
    default = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
    description = "Private subnet subnet"
    type = string
    default = "10.0.2.0/24"
}