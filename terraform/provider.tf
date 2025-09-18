############################################################
# Backend S3 - Armazena o Terraform State remotamente
############################################################
terraform {
  backend "s3" {
    bucket  = "iac-aws-s3-load-balancer" # Nome do bucket S3
    key     = "terraform.tfstate"          # Caminho do arquivo de state
    region  = "us-east-1"                  # Região do bucket
    encrypt = true                         # Criptografa o state
  }
}

############################################################
# Provider AWS
# Utiliza variável para a região e credenciais de ambiente
############################################################
variable "aws_region" {
  type        = string
  description = "Região AWS onde os recursos serão criados"
  default     = "us-east-1" # pode sobrescrever no terraform.tfvars
}

provider "aws" {
  region = var.aws_region
  # As credenciais podem ser fornecidas via:
  # 1. Variáveis de ambiente AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN
  # 2. Profile do AWS CLI configurado (~/.aws/credentials)
}
