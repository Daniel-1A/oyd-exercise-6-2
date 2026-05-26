output "alb_dns_name" {
  description = "The public DNS name of the Application Load Balancer — use this to send HTTP requests to the API."
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "The ARN of the Application Load Balancer."
  value       = aws_lb.main.arn
}

output "target_group_arn" {
  description = "The ARN of the Target Group that registers the EC2 instance."
  value       = aws_lb_target_group.api.arn
}
