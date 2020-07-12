resource "aws_sns_topic" "ctx_sent" {
  name = "ctx-sent"
}

output "ctx_sent_arn" {
  value = aws_sns_topic.ctx_sent.arn
}