# Declare the Security Group in RDS module
resource "aws_security_group" "allow_all" {
  name_prefix = "allow_all_"
  description = "Allow all inbound traffic to RDS"
  vpc_id      = var.vpc_id  # Ensure 'vpc_id' is passed from the root module

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all inbound traffic for testing
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Declare the DB Subnet Group
resource "aws_db_subnet_group" "default" {
  name        = "default-subnet-group"
  subnet_ids  = [var.subnet_id, var.subnet2_id]  # Pass subnet_id from root module
  description = "RDS Subnet Group"

  tags = {
    Name = "default-subnet-group"
  }
}

variable "db_username" {
  description = "The username for the RDS instance"
}

variable "db_password" {
  description = "The password for the RDS instance"
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID where the RDS instance will be created"
}

variable "subnet_id" {
  description = "Subnet ID where the RDS instance will be deployed"
}

variable "subnet2_id" {
  description = "Subnet2 ID where the RDS instance will be deployed"
}

variable "region" {
  description = "The AWS region where the RDS instance will be deployed"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.4.3"
  instance_class       = "db.m5d.large"
  db_name              = "springpetclinicdb"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.default.id
  multi_az             = false
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  tags = {
    Name = "SpringPetClinicRDSproj"
  }
}

