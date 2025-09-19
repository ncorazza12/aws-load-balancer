############################################################
# Variáveis do Network
############################################################
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnets" {
  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
  }
}

############################################################
# Variáveis do Load Balancer
############################################################
variable "ami" {
  default = "ami-00a929b66ed6e0de6"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "vockey"
}

############################################################
# Variável do Bucket S3
############################################################
variable "bucket_name" {
  default = "aws-s3-load-balancer-nickolas"
  type    = string

  validation {
    condition = (
      length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 &&
      can(regex("^[a-z0-9.-]+$", var.bucket_name)) &&
      can(regex("^[a-z0-9].*[a-z0-9]$", var.bucket_name)) &&
      !can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.bucket_name)) &&
      !can(regex("\\.-|-\\.", var.bucket_name)) &&
      !can(regex("\\.\\.", var.bucket_name)) &&
      !can(regex("--", var.bucket_name))
    )
    error_message = <<-EOT
      O nome do bucket S3 deve seguir as regras da AWS:
      - Entre 3 e 63 caracteres
      - Apenas letras minúsculas (a-z), números (0-9), pontos (.) e hífens (-)
      - Deve iniciar e terminar com letra ou número
      - Não pode parecer um endereço IP (ex: 192.168.1.1)
      - Não pode ter hífen antes/depois de ponto (ex: my-.bucket)
      - Não pode ter pontos ou hífens consecutivos
      - Não pode conter underscores, maiúsculas ou caracteres especiais
    EOT
  }
}
