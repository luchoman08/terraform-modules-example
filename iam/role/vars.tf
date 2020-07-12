# That var with information about ctx access policy arn
# is declared here to enforce the module caller to inject that
# var, that will be used in policy attachment to ctx service
# role
# The injection is done in the principal main.tf
variable "ctx_access_arn" {
  type = string
}