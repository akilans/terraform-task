# region
variable "region" {
  description = "Region name"
  type        = string
}

# env
variable "env" {
  description = "Environment name"
  type        = string
}


#vpc name
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

# vpc cidr range
variable "vpc_cidr_range" {
  description = "CIDR range for vpc"
}


# subnets
variable "subnets" {
  description = "Map of subnet with CIDR ranges"
  type        = map(string)
}
