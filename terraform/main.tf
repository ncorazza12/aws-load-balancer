############################################################
# Módulo Network
############################################################
module "network" {
  source   = "./modules/network"
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets
}

############################################################
# Módulo Load Balancer
############################################################
module "loadbalancer" {
  source            = "./modules/loadbalancer"
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.subnet_ids
  security_group_id = module.network.security_group_id
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  user_data_script  = "./scripts/user_data.sh"
}

############################################################
# Módulo S3 Bucket
############################################################
module "bucket" {
  source      = "./modules/bucket"
  bucket_name = var.bucket_name
}
