# Add a role that can be assumed by lambda resources
# This policy should only contain the
resource "aws_iam_role" "ctx_service" {
  name = "ctx-service-lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

#
resource "aws_iam_role_policy_attachment" "ctx_publish" {
  policy_arn = var.ctx_access_arn
  role = aws_iam_role.ctx_service.name
}

# Allow access to cloudwatch logs, that means, registry the console.logs
# in cloud watch to see them latter via cloud watch or insights
resource "aws_iam_role_policy_attachment" "logs" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role = aws_iam_role.ctx_service.name
}

# Export the context service arn to have it available from another
# modules via dependency inversion
# That var will be injected to lambda modules latter in the central project
# main file
output "ctx_service_arn" {
  value = aws_iam_role.ctx_service.arn
}