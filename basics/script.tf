provider "aws"{
region = "ap-south-1"}

resource "aws_vpc" "main"{
cidr_block="10.0.0.0/16"
}

resource "aws_subnet" "subnet_1"{
cidr_block="10.0.1.0/24"
vpc_id=aws_vpc.main.id
availability_zone = "ap-south-1a"
}

resource "aws_instance" "web"{
subnet_id=aws_subnet.subnet_1.id
ami="ami_12345678"
instance_type="t2.micro"
tags={
Name = "my-ec2"
}
}

resource "aws_s3_bucket" "bucket"{
bucket="my_unique_bucket_name_super_duper"
}



resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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


