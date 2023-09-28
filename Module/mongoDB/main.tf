resource "aws_docdb_cluster" "mongodb" {
    cluster_identifier     = "companyname-mongodb"
    engine                 = "docdb"
    engine_version         = "5.0.0"
    master_username        = "companyname"
    master_password        = "companyname1234"
    port                   = 27017
    storage_encrypted      = true
    vpc_security_group_ids = [var.mongodb_sg_id]
    skip_final_snapshot    = true
    db_subnet_group_name   = aws_docdb_subnet_group.docdb_subnet.name
    tags = {
        Name = "companyname Database"
    }
}

resource "aws_docdb_cluster_instance" "cluster_instance" {
  identifier         = "companyname-mongodb-instance"
  cluster_identifier = aws_docdb_cluster.mongodb.id
  engine             = aws_docdb_cluster.mongodb.engine
  instance_class     = "db.t3.medium"

  tags = {
    Name = "companyname DocDB Instance"
  }
}

resource "aws_docdb_subnet_group" "docdb_subnet" {
    name = "companyname-mongodb"
    
    subnet_ids = [var.private_subnet_id[0].id, var.private_subnet_id[1].id]

    tags = {
        Name = "companyname Database"
    }
}