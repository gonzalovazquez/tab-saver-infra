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
