# Declare the Security Group within this module
resource "aws_security_group" "allow_all" {
  name_prefix = "allow_all_"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id  # Ensure that 'vpc_id' is passed to the module

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

# Ensure the module has input variables defined for vpc_id, subnet_id, and region
variable "vpc_id" {
  description = "VPC ID where the load balancer will be created"
}

variable "subnet_id" {
  description = "Subnet ID where the load balancer will be deployed"
}

variable "subnet2_id" {
  description = "Subnet2 ID where the load balancer will be deployed"
}

variable "region" {
  description = "The region where the load balancer will be deployed"
}

resource "aws_lb" "main" {
  name               = "main-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.allow_all.id]
  subnets           = [var.subnet_id, var.subnet2_id]

  enable_deletion_protection = false

  tags = {
    Name = "main-lb"
  }
}

resource "aws_lb_target_group" "app" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      status_code = 200
      content_type = "text/plain"
      message_body = "OK"
    }
  }
}

