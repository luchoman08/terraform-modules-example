# Creates a zipped file that contains the code
# On longer projects is recommended to use a s3 bucket to have the
# zipped artifacts
data "archive_file" "ctx_receiver_zip" {
  type        = "zip"
  source_file  = "./../src/context/functions/ctx-receiver/main.js"
  output_path = "ctx-receiver.zip"
}

resource "aws_lambda_function" "ctx_receiver" {
  function_name = "ctx-receiver"
  filename = "ctx-receiver.zip"
  # On longer projects is recommended to use a s3 bucket to have the
  # zipped artifacts, that can be built via `make` or a custom continuous
  # integration on master merges hook
  # s3_bucket = var.bucket
  # s3_key = "node/ctx-receiver.zip"
  source_code_hash = data.archive_file.ctx_receiver_zip.output_base64sha256
  role = var.ctx_role
  handler = "main.handler"
  runtime = "nodejs12.x"
}

# Subscribe the lambda to the SNS, also as is seen before, a permission is needed
resource "aws_sns_topic_subscription" "ctx_receiver" {
  endpoint = aws_lambda_function.ctx_receiver.arn
  protocol = "lambda"
  topic_arn = var.ctx_sent_arn
}

# Create the lambda permission to invoke the specified function via SNS
# The sns subscription is not sufficient to have the lambda connected, the permission
# is always needed
resource "aws_lambda_permission" "ctx_receiver" {
  action        = "lambda:InvokeFunction"
  principal     = "sns.amazonaws.com"
  function_name = aws_lambda_function.ctx_receiver.function_name
  source_arn = var.ctx_sent_arn
}
