variable "vpc_cidr" {
	description = "CIDR block for the VPC"
	type        = string
	default = "10.0.0.0/16"
}

variable "vpc_name" {
	description = "Name of the VPC"
	type        = string
	default     = "MyVPC"
}

variable "public_subnet_cidr" {
	description = "CIDR block for the public subnet"
	type        = string
	default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
	description = "CIDR block for the private subnet"
	type        = string
	default = "10.0.1.0/24"
}

variable "availability_zone" {
	description = "Availability Zone for the subnets"
	type        = string
	default = "us-east-1"
}
