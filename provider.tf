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

locals {
  common_tags = {
    Project     = "TabManager"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

provider "aws" {
  region = var.aws_region
}











