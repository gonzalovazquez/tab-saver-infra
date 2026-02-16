# Temporary import blocks to recover existing AWS resources into Terraform state.
# These can be removed after a successful apply.

import {
  to = aws_cloudwatch_log_group.api_gateway
  id = "/aws/apigateway/tab-saver"
}

import {
  to = aws_dynamodb_table.tab_manager
  id = "tab-saver-table"
}

import {
  to = aws_iam_role.lambda_role
  id = "tab-saver-lambda-role"
}

import {
  to = aws_lambda_function.api
  id = "tab-saver-dev"
}

import {
  to = aws_lambda_permission.api_gateway
  id = "tab-saver-dev/AllowAPIGatewayInvoke"
}

import {
  to = aws_lambda_function_url.api
  id = "tab-saver-dev"
}

import {
  to = aws_iam_role_policy.lambda_dynamodb_policy
  id = "tab-saver-lambda-role:tab-saver-lambda-dynamodb-policy"
}

import {
  to = aws_iam_role_policy_attachment.lambda_basic_execution
  id = "tab-saver-lambda-role/arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
