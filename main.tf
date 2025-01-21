 provider "aws" {
     region = "us-east-1"
   }

   resource "aws_vpc" "main" {
     cidr_block = "10.0.0.0/16"
     enable_dns_support = true
     enable_dns_hostnames = true
   }

   resource "aws_subnet" "subnet" {
     vpc_id     = aws_vpc.main.id
     cidr_block = "10.0.1.0/24"
     availability_zone = "us-east-1a"
     map_public_ip_on_launch = true
   }

   resource "aws_security_group" "allow_ssh" {
     name_prefix = "allow_ssh"
     vpc_id      = aws_vpc.main.id

     ingress {
       from_port   = 22
       to_port     = 22
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
     }

     egress {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
     }
   }

   resource "aws_key_pair" "key_pair" {
     key_name   = "my-key-pair"
     public_key = file("~/.ssh/id_rsa.pub")
   }

   resource "aws_instance" "my_instance" {
     ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID (update as needed)
     instance_type = "t2.micro"
     subnet_id     = aws_subnet.subnet.id
     security_group = aws_security_group.allow_ssh.id
     key_name      = aws_key_pair.key_pair.key_name

     tags = {
       Name = "MyInstance"
     }
   }
