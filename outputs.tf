output "log_groups" {
  description = "Map of all created log groups with their name and ARN."
  value = {
    for k, v in aws_cloudwatch_log_group.this : k => {
      name = v.name
      arn  = v.arn
    }
  }
}

output "names" {
  description = "Map of logical key to log group name."
  value       = { for k, v in aws_cloudwatch_log_group.this : k => v.name }
}

output "arns" {
  description = "Map of logical key to log group ARN."
  value       = { for k, v in aws_cloudwatch_log_group.this : k => v.arn }
}
