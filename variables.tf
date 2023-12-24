# region
variable "region" {
  description = "Region name"
  type        = string
  default     = "ap-south-1"
}

# env
variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}


#vpc name
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

# vpc cidr range
variable "vpc_cidr_range" {
  description = "CIDR range for vpc"
  type        = string
  default     = "10.0.0.0/16"
}


# subnets
variable "subnets" {
  description = "Map of subnet with CIDR ranges"
  type        = map(string)
  default = {
    my-subnet1 = "10.0.1.0/24"
    my-subnet2 = "10.0.2.0/24"
  }
}



# instance type
variable "instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t2.micro"
}



# desired count
variable "desired_count" {
  description = "Desired count"
  type        = number
  default     = 2
}

# minimum count
variable "minimum_count" {
  description = "Minimum count"
  type        = number
  default     = 1
}


# maximum count
variable "maximum_count" {
  description = "Maximum count"
  type        = number
  default     = 4
}
