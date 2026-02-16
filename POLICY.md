# Policy

The following policy is created with the following permissions:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3BucketCreation",
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation",
                "s3:GetBucketVersioning",
                "s3:PutBucketVersioning",
                "s3:PutEncryptionConfiguration",
                "s3:GetEncryptionConfiguration"
            ],
            "Resource": [
                "arn:aws:s3:::tab-saver-*"
            ]
        },
        {
            "Sid": "S3StateManagement",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::tab-saver-*",
                "arn:aws:s3:::tab-saver-*/*"
            ]
        },
        {
            "Sid": "DynamoDBTableCreation",
            "Effect": "Allow",
            "Action": [
                "dynamodb:CreateTable",
                "dynamodb:DescribeTable",
                "dynamodb:DescribeContinuousBackups",
                "dynamodb:DescribeTimeToLive",
                "dynamodb:ListTables",
                "dynamodb:DeleteTable"
            ],
            "Resource": "arn:aws:dynamodb:*:366579856667:table/tab-saver-*"
        },
        {
            "Sid": "DynamoDBStateLocking",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:GetItem",
                "dynamodb:DeleteItem"
            ],
            "Resource": "arn:aws:dynamodb:*:366579856667:table/tab-saver-*"
        },
        {
            "Sid": "DynamoDBAppData",
            "Effect": "Allow",
            "Action": [
                "dynamodb:CreateTable",
                "dynamodb:DescribeTable",
                "dynamodb:DescribeContinuousBackups",
                "dynamodb:DescribeTimeToLive",
                "dynamodb:UpdateTable",
                "dynamodb:DeleteTable",
                "dynamodb:TagResource",
                "dynamodb:ListTagsOfResource"
            ],
            "Resource": "arn:aws:dynamodb:*:366579856667:table/tab-saver-*"
        },
        {
            "Sid": "LambdaManagement",
            "Effect": "Allow",
            "Action": [
                "lambda:CreateFunction",
                "lambda:GetFunction",
                "lambda:UpdateFunctionCode",
                "lambda:UpdateFunctionConfiguration",
                "lambda:DeleteFunction",
                "lambda:ListFunctions",
                "lambda:TagResource",
                "lambda:UntagResource"
            ],
            "Resource": "arn:aws:lambda:*:366579856667:function:tab-saver-*"
        },
        {
            "Sid": "APIGatewayV2Management",
            "Effect": "Allow",
            "Action": [
                "apigateway:GET",
                "apigateway:POST",
                "apigateway:PUT",
                "apigateway:PATCH",
                "apigateway:DELETE"
            ],
            "Resource": [
                "arn:aws:apigateway:*::/apis/*",
                "arn:aws:apigateway:*::/apis",
                "arn:aws:apigateway:*::/tags/*"
            ]
        },
        {
            "Sid": "IAMRoleManagement",
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:GetRole",
                "iam:UpdateAssumeRolePolicy",
                "iam:DeleteRole",
                "iam:PutRolePolicy",
                "iam:GetRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:AttachRolePolicy",
                "iam:DetachRolePolicy",
                "iam:ListAttachedRolePolicies",
                "iam:ListRolePolicies",
                "iam:TagRole",
                "iam:UntagRole",
                "iam:PassRole"
            ],
            "Resource": "arn:aws:iam::366579856667:role/tab-saver-*"
        },
        {
            "Sid": "CloudWatchLogs",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:DescribeLogGroups",
                "logs:DeleteLogGroup",
                "logs:PutRetentionPolicy",
                "logs:TagLogGroup",
                "logs:UntagLogGroup",
                "logs:ListTagsLogGroup",
                "logs:ListTagsForResource"
            ],
            "Resource": "arn:aws:logs:*:366579856667:log-group:*"
        },
        {
            "Sid": "CloudWatchLogDelivery",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogDelivery",
                "logs:GetLogDelivery",
                "logs:UpdateLogDelivery",
                "logs:DeleteLogDelivery",
                "logs:ListLogDeliveries",
                "logs:PutResourcePolicy",
                "logs:DescribeResourcePolicies"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ECRPull",
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchGetImage",
                "ecr:GetDownloadUrlForLayer"
            ],
            "Resource": "*"
        }
    ]
}
```
