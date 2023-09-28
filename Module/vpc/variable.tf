
variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "az" {
    type = list
    default = ["eu-central-1a", "eu-central-1b"]
}

variable "public_cidr_block" {
    type = list
    default = ["10.0.5.0/24", "10.0.7.0/24"]
}

variable "private_cidr_block" {
    type = list
    default = ["10.0.4.0/24", "10.0.6.0/24"]
}

variable "public_name" {
    type = list
    default = ["companyname-public-subnet-1a", "companyname-public-subnet-1b"]
}

variable "private_name" {
    type = list
    default = ["companyname-private-subnet-1a",  "companyname-privatez-subnet-1b"]
}

variable "igw_cidr" {
    type = string
    default = "0.0.0.0/0"
}

variable "public_rt_cidr" {
    type = string
    default = "0.0.0.0/0"
}

variable "private_rt_cidr" {
    type = string
    default = "0.0.0.0/0"
}