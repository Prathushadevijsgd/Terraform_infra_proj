module "vpc" {
  source   = "./modules/vpc"
  cidr     = var.vpc_cidr
  region   = var.region
}

module "ec2" {
  source        = "./modules/ec2"
  instance_type = var.instance_type
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.subnet_id
  region        = var.region
}

module "rds" {
  source       = "./modules/rds"
  db_username  = var.db_username
  db_password  = var.db_password
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.subnet_id
  subnet2_id   = module.vpc.subnet2_id 
  region       = var.region
}

module "load_balancer" {
  source    = "./modules/load_balancer"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
  subnet2_id   = module.vpc.subnet2_id
  region    = var.region
}

