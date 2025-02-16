variable "vpc_az" {
	type = string  
	default = "us-east-1"
}

variable "vpc_cidr" {
	type = string  
	default = "10.0.0.0/16"
}

variable "vpc_public_subnet" {
	type = string  
	default = "10.0.0.0/24"
}

variable "vpc_private_subnet" {
	type = string  
	default = "10.0.1.0/24"
}