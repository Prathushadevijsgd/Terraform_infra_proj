provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "capstone-project-devops"  # Replace with your unique S3 bucket name
    key    = "terraform/proj/statefile.tfstate"  # Path inside the bucket for the state file
    region = "us-east-1"  # AWS region for your S3 bucket
    encrypt = true  # Enable encryption for the state file

    dynamodb_table = "terraform-locks"  # The DynamoDB table name (ensure this exists)
    acl            = "bucket-owner-full-control" 
  }
}

