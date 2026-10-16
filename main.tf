resource "aws_cloudwatch_log_group" "this" {
  for_each = var.create ? var.log_groups : {}

  name              = each.value.name
  retention_in_days = lookup(each.value, "retention_in_days", var.retention_in_days)
  kms_key_id        = lookup(each.value, "kms_key_id", var.kms_key_id) != "" ? lookup(each.value, "kms_key_id", var.kms_key_id) : null
  log_group_class   = lookup(each.value, "log_group_class", var.log_group_class)
  skip_destroy      = lookup(each.value, "skip_destroy", var.skip_destroy)

  deletion_protection_enabled = lookup(each.value, "deletion_protection_enabled", var.deletion_protection_enabled)

  tags = merge(var.tags, try(each.value.tags, {}))
}
