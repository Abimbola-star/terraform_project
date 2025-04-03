//vpc code
resource "aws_vpc" "terraform-vpc-docker" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    name: "terraform-vpc-docker"
    env: "Dev"
    Team: "docker"
  }
}

#Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform-vpc-docker.id
  tags = {
    name: "terraform-vpc-docker"
    env: "Dev"
    Team: "docker"
  }
  }

#public subnet
resource "aws_subnet" "pub-sub1" {
  vpc_id = aws_vpc.terraform-vpc-docker.id
  map_public_ip_on_launch = true
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-useast-1a"
  }
  }
resource "aws_subnet" "pub-sub2" {
  vpc_id = aws_vpc.terraform-vpc-docker.id
  map_public_ip_on_launch = true
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "public-useast-1b"
  }
  }
  // private subnet
  resource "aws_subnet" "priv-sub1" {
  vpc_id = aws_vpc.terraform-vpc-docker.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-useast-1a"
  }
  }
  resource "aws_subnet" "priv-sub2" {
  vpc_id = aws_vpc.terraform-vpc-docker.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-useast-1b"
  }
  }
  #private route table
  resource "aws_route_table" "rtpriv" {
    vpc_id = aws_vpc.terraform-vpc-docker.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }  
  }
  #private route table
  resource "aws_route_table" "rtpub" {
    vpc_id = aws_vpc.terraform-vpc-docker.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
  }

  #private route table association
  resource "aws_route_table_association" "rtapriv1" {
    subnet_id = aws_subnet.priv-sub1.id
    route_table_id = aws_route_table.rtpriv.id
  }
  resource "aws_route_table_association" "rtapriv2" {
    subnet_id = aws_subnet.priv-sub2.id
    route_table_id = aws_route_table.rtpriv.id
  }
  #public route table association
  resource "aws_route_table_association" "rtapub1" {
    subnet_id = aws_subnet.pub-sub1.id
    route_table_id = aws_route_table.rtpub.id
  }
  resource "aws_route_table_association" "rtapub2" {
    subnet_id = aws_subnet.pub-sub2.id
    route_table_id = aws_route_table.rtpub.id
  }