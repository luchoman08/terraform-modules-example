module "role" {
  source = "./role"
  ctx_access_arn = module.policy.ctx_publish_arn
}

module "policy" {
  source = "./policy"
}

output "ctx_role_service_arn" {
  value = module.role.ctx_service_arn
}
