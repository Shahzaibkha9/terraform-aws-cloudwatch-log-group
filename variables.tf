variable "create" {
  type        = bool
  description = "Controls whether log groups are created."
  default     = true
}

variable "log_groups" {
  type        = any
  description = <<-EOT
    Map of log groups to create. Each key is a logical name; each value is a config object.
    Supported per-group keys: name, retention_in_days, kms_key_id, log_group_class, skip_destroy, deletion_protection_enabled, tags.
    Example:
      log_groups = {
        app    = { name = "/ecs/my-app" }
        access = { name = "/ecs/my-app/access", retention_in_days = 7, log_group_class = "INFREQUENT_ACCESS" }
      }
  EOT
  default     = {}
}

variable "retention_in_days" {
  type        = number
  description = "Default retention in days applied to all log groups unless overridden. 0 means never expire."
  default     = 90
}

variable "kms_key_id" {
  type        = string
  description = "Default KMS key ARN for encryption. Can be overridden per log group."
  default     = ""
}

variable "log_group_class" {
  type        = string
  description = "Default log group class. STANDARD or INFREQUENT_ACCESS."
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "INFREQUENT_ACCESS"], var.log_group_class)
    error_message = "log_group_class must be STANDARD or INFREQUENT_ACCESS."
  }
}

variable "skip_destroy" {
  type        = bool
  description = "If true, log groups will not be deleted on destroy."
  default     = false
}

variable "deletion_protection_enabled" {
  type        = bool
  description = "If true, the log group cannot be deleted."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Default tags applied to all log groups. Merged with per-group tags."
  default     = {}
}
