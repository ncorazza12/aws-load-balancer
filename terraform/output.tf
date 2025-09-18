output "lb_url" {
  value       = "http://${module.loadbalancer.lb_dns}"
  description = "URL pública do Load Balancer"
}
