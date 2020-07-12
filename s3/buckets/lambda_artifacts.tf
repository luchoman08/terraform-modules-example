resource "aws_s3_bucket" "lambda_artifacts" {
  bucket = "meltan-lambda-artifacts"
}

output "lambda_artifacts_name" {
  value = aws_s3_bucket.lambda_artifacts.bucket
}