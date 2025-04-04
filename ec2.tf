resource "aws_instance" "server1" {
  ami = "ami-02f624c08a83ca16f"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pub-sub1.id
  vpc_security_group_ids = [ aws_security_group.terraformsg-docker.id ]
  key_name = aws_key_pair.mykey.key_name
  user_data = file("setup.sh")

  tags = {
    Name = "Terraform_instance"
  }
}
 