output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private_subnet
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.nat-gw.id
}

output "mongodb_sg_id" {
  value = aws_security_group.mongodb_sg.id
}

output "companyname_sg_id" {
  value = aws_security_group.micae_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}