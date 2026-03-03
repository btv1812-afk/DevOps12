variable "vpc_id" {
    description = "VPC ID where resources will be created"
    type = string
    default = "vpc-0097f6d36d724839d"
  
}

variable "list_of_open_ports" {
    description = "List of YCP ports to open"
    type = list(number)
    default = [ 80, 22 ]
}