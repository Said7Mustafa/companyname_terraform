resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    tags = {
        Name = "companyname-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    count = 2
    vpc_id = aws_vpc.vpc.id
    cidr_block = "${element(var.public_cidr_block, count.index)}"
    availability_zone = "${element(var.az, count.index)}"

    tags = {
        count = length(var.public_name)
        Name = var.public_name[count.index]
    }
}

resource "aws_subnet" "private_subnet" {
    count = 2
    vpc_id = aws_vpc.vpc.id
    cidr_block = "${element(var.private_cidr_block, count.index)}"
    availability_zone = "${element(var.az, count.index)}"

    tags = {
        count = length(var.private_name)
        Name = var.private_name[count.index]
    }    
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "companyname-igw"
    }
}


resource "aws_eip" "nat_eip" {
    vpc = true
    depends_on = [aws_internet_gateway.igw]
    tags = {
        Name = "companyname-eip"
    }
}


resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet[0].id

    tags = {
        Name = "companyname-nat"
    }

    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = var.public_rt_cidr
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "companyname-public-route-table"
    }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = var.private_rt_cidr
        gateway_id = aws_nat_gateway.nat-gw.id
    }
    
    tags = {
        Name = "companyname-private-route-table"
    }
}

resource "aws_route_table_association" "public_rt_subnet_association_1" {
    subnet_id = aws_subnet.public_subnet[0].id
    route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_rt_subnet_association_2" {
    subnet_id = aws_subnet.public_subnet[1].id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_subnet_association_1" {
    subnet_id = aws_subnet.private_subnet[0].id
    route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private_rt_subnet_association_2" {
    subnet_id = aws_subnet.private_subnet[1].id
    route_table_id = aws_route_table.private_route_table.id
}

# resource "aws_db_subnet_group" "docdb_subnet_group" {
#     name = "companyname-docdb-subnet-group"
#     subnet_ids = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]
# }

resource "aws_security_group" "mongodb_sg" {
  name        = "mongodb-sg"
  description = "MongoDB Security Group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = ""
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    security_groups  = [aws_security_group.companyname_sg.id] 
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
        Name = "companyname-mongodb-sg"
    }
}

resource "aws_security_group" "companyname_sg" {
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = ""
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "companyname-sg"
    }
}

resource "aws_security_group" "alb_sg" {
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = ""
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "companyname-sg"
    }
}