output "vpc_id" {
	value = aws_vpc.myvpc.id
}

output "subnet_id" {
	value = aws_subnet.mysubnet.id
}

output "internetgateway_id" {
	value = aws_internet_gateway.myigw.id
}