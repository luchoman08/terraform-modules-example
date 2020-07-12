# Creates a zipped file that contains the code
# On longer projects is recommended use a s3 bucket to have the
# zipped artifacts
data "archive_file" "ctx_sender_zip" {
  type        = "zip"
  source_file  = "./../src/context/functions/ctx-receiver/main.js"
  output_path = "ctx-sender.zip"
}

resource "aws_lambda_function" "ctx_sender" {
  function_name = "ctx-sender"
  filename = "ctx-sender.zip"
  # On longer projects is recommended to use a s3 bucket to have the
  # zipped artifacts, that can be built via `make` or a custom continuous
  # integration on master merges hook
  # s3_bucket = var.bucket
  # s3_key = "node/ctx-sender.zip"
  source_code_hash = data.archive_file.ctx_sender_zip.output_base64sha256
  role = var.ctx_role
  runtime = "nodejs12.x"
  handler = "main.handler"
}