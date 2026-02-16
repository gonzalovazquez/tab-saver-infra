# ============================================================
# lambda.tf
# ============================================================

resource "aws_lambda_function" "api" {
  function_name = "${var.app_name}-${var.environment}"
  role          = aws_iam_role.lambda_role.arn
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory_size

  # Use container image 
  package_type = "Image"
  image_uri    = var.lambda_image_uri != "" ? var.lambda_image_uri : "public.ecr.aws/lambda/python:3.13"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.tab_manager.name
      ENVIRONMENT    = var.environment
    }
  }

  depends_on = [
    aws_iam_role_policy.lambda_dynamodb_policy
  ]

  lifecycle {
    ignore_changes = [image_uri]
  }
}

resource "aws_lambda_function_url" "api" {
  function_name          = aws_lambda_function.api.function_name
  authorization_type     = "NONE"
  cors {
    allow_origins = ["*"]
    allow_methods = ["*"]
    allow_headers = ["content-type"]
  }

  depends_on = [aws_lambda_function.api]
}