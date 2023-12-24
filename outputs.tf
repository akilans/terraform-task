# VPC id
output "vpc_id" {
  description = "vpc id"
  value       = module.vpc_module.vpc_id
}

# ALB dns name
output "alb_url" {
  description = "Application URL"
  value       = module.asg_module.alb_url
}
