output "lb_dns" {
  value       = aws_lb.this.dns_name
  description = "DNS público do Load Balancer"
}
