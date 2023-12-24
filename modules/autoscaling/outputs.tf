output "alb_url" {
  description = "Aceess Application - ALB URL"
  value       = "http://${aws_lb.my-alb.dns_name}"
}
