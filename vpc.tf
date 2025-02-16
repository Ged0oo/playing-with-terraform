// Defines AWS as the infrastructure provider
provider "aws" {
  	region = var.vpc_az
}

// Defines Virtual Private Cloud (VPC)
resource "aws_vpc" "myvpc" {
	cidr_block = var.vpc_cidr
	tags = {
		Name = "MyVPC"
	}

	provisioner "local-exec" {
		command = "echo ${self.id} > aws_vpc_id.txt"
	}
}

// Creates public subnet 
resource "aws_subnet" "mysubnet" {
	vpc_id                  = aws_vpc.myvpc.id
	cidr_block              = var.vpc_public_subnet
	map_public_ip_on_launch = true
	availability_zone       = "us-east-1a"
	tags = {
		Name = "MySubnet"
	}
	provisioner "local-exec" {
		command = "echo ${self.id} > public_subnet_id.txt"
	}
}

// Creates private subnet
resource "aws_subnet" "private_subnet" {
	vpc_id                  = aws_vpc.myvpc.id
	cidr_block              = var.vpc_private_subnet
	map_public_ip_on_launch = false
	availability_zone       = "us-east-1a"

	tags = {
		Name = "PrivateSubnet"
	}
	provisioner "local-exec" {
		command = "echo ${self.id} > private_subnet_id.txt"
	}
}

// Attaches an Internet Gateway to the VPC 
// to allow public internet access.
resource "aws_internet_gateway" "myigw" {
	vpc_id = aws_vpc.myvpc.id
	tags = {
		Name = "MyInternetGateway"
	}
	provisioner "local-exec" {
		command = "echo ${self.id} > internetgateway_id.txt"
	}
}

// Creates a Route Table within the VPC.
resource "aws_route_table" "myrt" {
	vpc_id = aws_vpc.myvpc.id
	tags = {
		Name = "MyRouteTable"
	}
}

// Define Route for Internet Access
resource "aws_route" "default_route" {
  	route_table_id         = aws_route_table.myrt.id
  	gateway_id             = aws_internet_gateway.myigw.id
    destination_cidr_block = "0.0.0.0/0"
}

// Associates the route table with the subnet
// enabling internet access for instances in this subnet.
resource "aws_route_table_association" "myrta" {
	subnet_id      = aws_subnet.mysubnet.id
	route_table_id = aws_route_table.myrt.id
}

// Creates private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "PrivateRouteTable"
  }
}

// Associates the private subnet with private route table
resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}