# ============================================================
# lambda.tf
# ============================================================

resource "aws_lambda_function" "api" {
  filename      = "lambda_function.zip"
  function_name = "${var.app_name}-api"
  role          = aws_iam_role.lambda_role.arn
  handler       = "src.app.lambda_handler"
  runtime       = "python3.13"
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory_size

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.tab_manager.name
      AWS_REGION     = var.aws_region
    }
  }

  depends_on = [
    aws_iam_role_policy.lambda_dynamodb_policy
  ]

  tags = {
    Name = "${var.app_name}-api-function"
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