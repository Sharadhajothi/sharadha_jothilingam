module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
}

module "vpc_2" {
  source      = "./modules/vpc"
  vpc_cidr  = "10.1.0.0/16"
  public_subnet_cidr = "10.1.1.0/24"
}