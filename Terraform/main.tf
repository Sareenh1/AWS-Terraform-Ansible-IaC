provider "aws" {
region = "ap-south-1" 
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/my_aws_key.pub")  # Update with your public key file location
}

resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-00bb6a80f01f03502" 
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_ssh.id]
  subnet_id       = aws_subnet.subnet.id
  key_name = aws_key_pair.key_pair.key_name
  tags = {
    Name = "Ubuntu-Instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.ubuntu_instance.public_ip
}
