# subnets
variable "subnets" {
  description = "Map of subnet with CIDR ranges"
  type        = map(string)
  default = {
    my-subnet1 = "10.0.1.0/24"
    my-subnet2 = "10.0.2.0/24"
    my-subnet3 = "10.0.3.0/24"
  }
}

# env
variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
