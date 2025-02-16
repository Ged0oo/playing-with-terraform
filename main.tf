module "networking" {
	source              = "/home/nagy/Desktop/Dev/terraform/svg1/network"
	vpc_cidr            = var.vpc_cidr
	vpc_name            = var.vpc_name
	public_subnet_cidr  = var.public_subnet
	private_subnet_cidr = var.private_subnet
	availability_zone   = var.vpc_az
}

// Define AWS provider
provider "aws" {
  region = "us-east-1"
}
