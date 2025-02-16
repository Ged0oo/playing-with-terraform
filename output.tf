output "vpc_id" {
	value = module.networking.vpc_id
}

output "public_subnet_id" {
	value = module.networking.public_subnet_id
}

output "private_subnet_id" {
	value = module.networking.private_subnet_id
}

output "internetgateway_id" {
	value = module.networking.internet_gateway_id
}