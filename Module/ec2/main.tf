resource "aws_instance" "web" {
    ami = "ami-0ab1a82de7ca5889c"
    instance_type = "t3.xlarge"
    subnet_id = var.private_subnet_id[0].id
    vpc_security_group_ids = [var.companyname_sg_id]
    key_name = "companyname-key"
    associate_public_ip_address = false


    tags = {
        Name = "companyname Web Instance"
    }
}

resource "aws_instance" "web-gpu" {
    ami = "ami-0ab1a82de7ca5889c"
    instance_type = "g4ad.xlarge"
    subnet_id = var.private_subnet_id[0].id
    vpc_security_group_ids = [var.companyname_sg_id]
    key_name = "companyname-gpu-key"
    associate_public_ip_address = false

    tags = {
        Name = "companyname GPU instance"
    }
}

resource "aws_instance" "rport" {
    ami = "ami-0ab1a82de7ca5889c"
    instance_type = "t2.micro"
    subnet_id = var.private_subnet_id[0].id
    vpc_security_group_ids = [var.companyname_sg_id]
    key_name = "companyname-key"
    associate_public_ip_address = false


    tags = {
        Name = "RPort"
    }
}