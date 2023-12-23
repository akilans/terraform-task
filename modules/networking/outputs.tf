# list of subnets id
output "subnets" {
  description = "list of subnets id"
  value       = [for subnet in aws_subnet.mysubnets : subnet.id]
}


# vpc id id
output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.myvpc.id
}

# ec2 sg id
output "ec2_sg_id" {
  description = "EC2 ssh sg id"
  value       = aws_security_group.allow_ssh.id
}
