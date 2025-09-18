variable "vpc_cidr" {
  type = string
}

variable "subnets" {
  type = map(string)
  # exemplo: {"us-east-1a" = "10.0.1.0/24", "us-east-1b" = "10.0.2.0/24"}
}
