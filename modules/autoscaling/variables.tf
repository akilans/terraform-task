# env
variable "env" {
  description = "Environment name"
  type        = string
}

# vpc id
variable "vpc_id" {
  description = "VPC id"
  type        = string
}


# instance type
variable "instance_type" {
  description = "Type of instance"
  type        = string
}



# desired count
variable "desired_count" {
  description = "Desired count"
  type        = number
}

# minimum count
variable "minimum_count" {
  description = "Minimum count"
  type        = number
}


# maximum count
variable "maximum_count" {
  description = "Maximum count"
  type        = number
}

# subnet ids list
variable "subnets_ids" {
  description = "List of subnet ids"
  type        = list(string)
}
