variable "ctx_sent_arn" {
  type = string
}

# This var is used if you want a custom bucket to store
# the lambda zip artifacts
variable "bucket" {
  type = string
}

variable "ctx_role" {
  type = string
}