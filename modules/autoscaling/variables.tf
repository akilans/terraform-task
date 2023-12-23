# env
variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# env
variable "vpc_id" {
  description = "VPC id"
  type        = string
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

