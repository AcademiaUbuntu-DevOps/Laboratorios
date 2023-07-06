provider "aws" {
  region = "us-east-1"
  shared_config_files      = ["/Users/su-directorio/.aws/conf"]
  shared_credentials_files = ["/Users/su-directorio/.aws/credentials"]
  profile                  = "su profile"
}


resource "aws_iam_role" "academia" {
  name               = "academia-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  # Otros atributos y políticas asociadas al rol
}

resource "aws_lambda_function" "academia" {
  filename      = "academia.zip"
  function_name = "academia-lambda"
  role          = aws_iam_role.academia.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
}

resource "aws_cloudwatch_event_rule" "academia" {
  name        = "academia-event-rule"
  description = "Lambda request every 5 minutes"

  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "academia" {
  rule      = aws_cloudwatch_event_rule.academia.name
  arn       = aws_lambda_function.academia.arn
}
