# data to fetch all az
data "aws_availability_zones" "aws_zones" {
  state = "available"
}


# create vpc
resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_cidr_range
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
    env  = var.env
  }
}


# create subnet in each az
resource "aws_subnet" "mysubnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.aws_zones.names[index(keys(var.subnets), each.key)]
  tags = {
    Name = each.key
    env  = var.env
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    env  = var.env
    Name = "my-igw"
  }
}

# adding IG to default route table for the new VPC
resource "aws_default_route_table" "default_rt" {
  default_route_table_id = aws_vpc.myvpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    env  = var.env
    Name = "my-rt"
  }
}


# security group to allow SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "allow_ssh_sg"
    env  = var.env
  }
}
