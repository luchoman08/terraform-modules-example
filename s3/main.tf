module "buckets" {
  source = "./buckets"
}

output "lambda_artifacts_bucket_name" {
  value = module.buckets.lambda_artifacts_name
}