variable "additional_tags" {
  type        = map(string)
  description = "(Optional) Additional tags add to all module's resources"
  default     = {}
}

variable "environment" {
  type        = string
  description = "(Optional) Deploy aws S3 Bucket into dev | test | prod"
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The 'environment' variable must be one of 'dev', 'staging', or 'prod'."
  }
}

variable "lifetime_tag" {
  type        = string
  description = <<EOT
(Optional) Set S3 Bucket would be automatically deleted
Pattern:
 - external : keep S3 Bucket permanently
 - relative-<days | months | years>-xxx: keep S3 Bucket within xxx days, months or years
 - absolute-<year>-<month>-<day>: keep S3 Bucket until <year>-<month>-<day>
Ex: relative-days-7, absolute-2024-09-02
EOT
  default     = ""
}

variable "os_version" {
  type        = string
  description = "(Required) OS version of base image"
}

variable "repository" {
  type        = string
  description = "(Required) Git repository name"
}

variable "verbose_logging" {
  type        = bool
  default     = false
  description = "(Optional) Enable verbose logging for Ansible"
}