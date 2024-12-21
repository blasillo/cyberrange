variable "aws_region" {  
    description = "AWS Region"
}


variable "vpc_cidr_block" {  
    description = "Main VPC CIDR Block"
}

variable "availability_zones" {
   type = list(string)
   description = "AWS Region Availability Zones"
}

variable "public_subnet_cidr_block" {
   type = list(string)
   description = "Public Subnet CIDR Block"
}

variable "private_subnet_cidr_block" {
   type = list(string)
   description = "Private Subnet CIDR Block"
}

variable "database_subnet_cidr_block" {
   type = list(string)
   description = "Database Subnet CIDR Block"
}

