resource "aws_security_group" "terraformsg-docker" {
  name = "terraformsg-docker"
  description = "Allow web traffic and SSH"
  vpc_id = aws_vpc.terraform-vpc-docker.id

  ingress {
    description = "SSH from specific IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["24.13.172.239/32"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraformsg-docker"
  }
  depends_on = [ aws_vpc.terraform-vpc-docker ] 
}


