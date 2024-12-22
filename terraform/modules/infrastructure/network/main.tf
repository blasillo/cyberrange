
#-------------------------------
# AWS Provider
#-------------------------------
provider "aws" {
    region     = "${var.region}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"            
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"    
  tags = {
    Name = "CyberRange-VPC"      
  }         
}


resource "aws_subnet" "public-subnet" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
      Name = "CyberRange-PublicSubnet"
  }
}

resource "aws_subnet" "private-subnet" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags =  {
        Name = "CyberRange-PrivateSubnet"
    }
}

resource "aws_internet_gateway" "MyIGW" {
    vpc_id = "${aws_vpc.main.id}"
    tags =  {
        Name = "CyberRange-IGW"
    }
}

resource "aws_route_table" "publicrt" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.MyIGW.id}"
    }
    tags = {
        Name = "CyberRange-PublicRT"
    }
}

resource "aws_route_table" "privatert" {
    vpc_id = "${aws_vpc.main.id}"
    tags = {
        Name = "PrivateRouteTable"
    }
}

resource "aws_route_table_association" "public-association"{
    subnet_id = "${aws_subnet.public-subnet.id}"
    route_table_id = "${aws_route_table.publicrt.id}"
}

resource "aws_route_table_association" "private-association"{
    subnet_id = "${aws_subnet.private-subnet.id}"
    route_table_id = "${aws_route_table.privatert.id}"
}