variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t4g.medium"
}

variable "vpc_id" {
  description = "The VPC ID"
}

variable "subnet_id" {
  description = "The Subnet ID"
}

variable "region" {
  description = "The region where the instance will be deployed"
}

resource "aws_security_group" "allow_all" {
  vpc_id = var.vpc_id
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
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami = "ami-0b29c89c15cfb8a6d" 
  instance_type = var.instance_type
  key_name = "tertest"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "SpringPetClinic"
  }
}

