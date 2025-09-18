module "network" {
  source   = "./modules/network"
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets
}

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
