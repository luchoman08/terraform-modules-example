resource "aws_iam_policy" "ctx_publish" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sns:Publish",
            "Resource": "arn:aws:sns:*:*:ctx-sent"
        }
    ]
}
EOF
}

output "ctx_publish_arn" {
  value = aws_iam_policy.ctx_publish.arn
}