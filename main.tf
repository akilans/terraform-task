module "vpc_module" {
  source = "./modules/networking"
}

module "asg_module" {
  source = "./modules/autoscaling"
  vpc_id = module.vpc_module.vpc_id
}
