module "vpc" {
    source = "./Module/vpc"
}

module "ec2" {
    source = "./Module/ec2"
    mongodb_sg_id = module.vpc.mongodb_sg_id
    companyname_sg_id = module.vpc.companyname_sg_id
    private_subnet_id =  module.vpc.private_subnet_id
}

module "mongoDB" {
    source = "./Module/mongoDB"
    public_subnet_id = module.vpc.public_subnet_id
    private_subnet_id = module.vpc.private_subnet_id
    mongodb_sg_id = module.vpc.mongodb_sg_id
}

module "alb" {
    source = "./Module/alb"
    companyname_sg_id = module.vpc.companyname_sg_id
    public_subnet_id = module.vpc.public_subnet_id
    alb_sg_id = module.vpc.alb_sg_id
    vpc_id = module.vpc.vpc_id
}