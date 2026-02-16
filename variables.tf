# ============================================================
# variables.tf
# ============================================================

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "tab-saver"
}

variable "lambda_memory_size" {
  description = "Lambda memory size in MB (free tier: 128-1024)"
  type        = number
  default     = 256
}

variable "lambda_timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 30
}

variable "dynamodb_billing_mode" {
  description = "DynamoDB billing mode (PAY_PER_REQUEST = free tier)"
  type        = string
  default     = "PAY_PER_REQUEST"
}