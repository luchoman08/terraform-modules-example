module "iam" {
  source = "./iam"
}

# Define lambda module and inject all the needed vars to use them
# in lambda configs like role attachments and sns subscriptions
module "lambda" {
  source = "./lambda"
  ctx_sent_arn = module.sns.ctx_sent_arn
  ctx_role = module.iam.ctx_role_service_arn
  bucket = module.s3.lambda_artifacts_bucket_name
}

module "sns" {
  source = "./sns"

}

module "s3" {
  source = "./s3"
}

provider "aws" {
  region = "us-east-1"
}

# Export as an output the created s3 bucket name, with this config you can
# see the bucket arn via `terraform output` command
output "lambda_bucket_name" {
  value = module.s3.lambda_artifacts_bucket_name
}