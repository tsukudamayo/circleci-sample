# Cognito
resource "aws_cognito_user_pool" "InesusDevUserpool" {
  name = "InesusDevUserpool"
}

# APIGateway
resource "aws_api_gateway_rest_api" "InesusAPI" {
  name        = "InesusAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "InesusResource" {
  rest_api_id = aws_api_gateway_rest_api.InesusAPI.id
  parent_id   = aws_api_gateway_rest_api.InesusAPI.root_resource_id
  path_part   = "mydemoresource"
}

# API Gateway
resource "aws_api_gateway_rest_api" "example" {
  name        = "ServerlessExample"
  description = "Terraform Serverless Application Example"
}

# Lambda
resource "aws_lambda_function" "example" {
  function_name = "ServerlessExample"

  s3_bucket = "inesus-terraform-serverless-example"
  s3_key    = "v1.0.0/example.zip"

  handler = "main.handler"
  runtime = "nodejs10.x"

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
  name               = "serverless_example_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


# Aurora
resource "aws_rds_cluster" "demo" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora"
  engine_version          = "5.6"
  database_name           = "inesusdb"
  master_username         = "inesusadmin"
  master_password         = "inesusadmin"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
