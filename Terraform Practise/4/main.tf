module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = {
    "subnet_a" = "10.0.1.0/24"
    "subnet_b" = "10.0.2.0/24"
  }
}

module "vpc_2" {
  source      = "./modules/vpc"
  vpc_cidr  = "10.1.0.0/16"
  public_subnet_cidr = {
    "subnet_a" = "10.1.1.0/24"
    "subnet_b" = "10.1.2.0/24"
  }
}