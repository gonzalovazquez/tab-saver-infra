# ============================================================
# Tab Manager Real API - OpenTofu Infrastructure
# ============================================================

# provider.tf
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend configuration - uncomment after initial setup
  # backend "s3" {
  #   bucket         = "tab-saver-terraform-state"
  #   key            = "prod/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "tab-saver-terraform-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "TabManager"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# Separate provider without default_tags for API Gateway resources
# API Gateway V2 requires apigateway:TagResource which is not a valid IAM action
provider "aws" {
  alias  = "no_tags"
  region = var.aws_region
}











