variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t4g.medium"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "db_username" {
  description = "MySQL Database Username"
  default     = "admin"
}

variable "db_password" {
  description = "MySQL Database Password"
  default     = "adminpassword"
  sensitive   = true
}

variable "region" {
  description = "AWS Region"
  default     = "us-us-east-1"
}

