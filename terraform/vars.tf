# Variáveis do network
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnets" {
  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
  }
}

# Variáveis do loadbalancer
variable "ami" {
  default = "ami-00a929b66ed6e0de6"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "vockey"
}
