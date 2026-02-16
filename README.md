# Tab Saver Infrastructure

Terraform/OpenTofu infrastructure-as-code for the [Tab Saver API](https://github.com/gonzalovazquez/tab-saver-api). Provisions the full AWS serverless stack: Lambda, API Gateway, DynamoDB, IAM, and CloudWatch.

## Architecture

```
Client --> API Gateway (HTTP) --> Lambda (Python 3.13) --> DynamoDB
                                      |
                                      v
                                 CloudWatch Logs
```

## Resources Provisioned

| Resource | Description |
|----------|-------------|
| **Lambda Function** | Runs the Flask app via `lambda_handler` (256 MB, 30s timeout) |
| **Lambda Function URL** | Direct invocation URL with CORS enabled |
| **API Gateway v2 (HTTP)** | HTTP API with `$default` stage and auto-deploy |
| **DynamoDB Table** | Single-table design with 2 GSIs and DynamoDB Streams |
| **IAM Role & Policies** | Least-privilege Lambda execution role with DynamoDB access |
| **CloudWatch Log Group** | API Gateway access logs (7-day retention) |

## DynamoDB Table Design

**Primary key:** `entity_type` (partition) + `id` (sort)

| GSI | Hash Key | Range Key | Purpose |
|-----|----------|-----------|---------|
| `entity_type_created_at_idx` | `entity_type` | `created_at` | Sort entities by date |
| `entity_type_tag_id_idx` | `entity_type` | `tag_id` | Query tab-tag associations by tag |

TTL (`expire_at`) and DynamoDB Streams (`NEW_AND_OLD_IMAGES`) are configured but TTL is disabled by default.

## Prerequisites

- [Terraform](https://www.terraform.io/) >= 1.0 or [OpenTofu](https://opentofu.org/)
- AWS CLI configured with appropriate credentials
- A `lambda_function.zip` deployment package built from the [Tab Saver API](https://github.com/gonzalovazquez/tab-saver-api)

## Usage

### Initialize

```bash
terraform init
```

### Preview changes

```bash
terraform plan
```

### Deploy

```bash
terraform apply
```

### Destroy

```bash
terraform destroy
```

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region | `us-east-1` |
| `environment` | Environment name | `prod` |
| `app_name` | Application name (used as resource prefix) | `tab-saver` |
| `lambda_memory_size` | Lambda memory in MB | `256` |
| `lambda_timeout` | Lambda timeout in seconds | `30` |
| `dynamodb_billing_mode` | DynamoDB billing mode | `PAY_PER_REQUEST` |

Override defaults in `terraform.tfvars` or via CLI flags.

## Outputs

| Output | Description |
|--------|-------------|
| `api_endpoint` | API Gateway endpoint URL |
| `api_invoke_url` | API Gateway invoke URL |
| `lambda_function_name` | Lambda function name |
| `lambda_function_arn` | Lambda function ARN |
| `dynamodb_table_name` | DynamoDB table name |
| `dynamodb_table_arn` | DynamoDB table ARN |
| `iam_role_arn` | Lambda IAM role ARN |

## Remote State (Optional)

An S3 backend is preconfigured but commented out in `provider.tf`. To enable it, create the S3 bucket and DynamoDB lock table, then uncomment the `backend "s3"` block.

## File Structure

```
TabSaverInfra/
├── provider.tf        # Terraform/AWS provider config and backend
├── variables.tf       # Input variables
├── terraform.tfvars   # Variable values
├── lambda.tf          # Lambda function and function URL
├── api_gateway.tf     # HTTP API Gateway, stage, integration, and logs
├── dynamodb.tf        # DynamoDB table with GSIs
├── iam.tf             # Lambda execution role and DynamoDB policy
├── outputs.tf         # Stack outputs
└── main.tf
```

## License

MIT
