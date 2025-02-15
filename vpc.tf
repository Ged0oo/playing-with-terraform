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
}

// Creates a subnet 
resource "aws_subnet" "mysubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.vpc_subnet
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "MySubnet"
  }
}

// Attaches an Internet Gateway to the VPC 
// to allow public internet access.
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "MyInternetGateway"
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