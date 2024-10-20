variable "additional_tags" {
  type        = map(string)
  description = "(Optional) Additional tags add to all module's resources"
  default     = {}
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "(Optional) t2.micro"
}

variable "ec2_region" {
  type        = string
  description = "EC2 region"
  default     = "(Optional) us-west-2"
}

variable "enabled_force_deregister" {
  type        = bool
  description = "(Optional) Force deregister AMI"
  default     = false
}

variable "enabled_force_delete_snapshot" {
  type        = bool
  description = "(Optional) Force delete snapshot"
  default     = false
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

variable "image_description" {
  type        = string
  description = "(Optional) AMI description"
  default     = "AMI created by Packer"
}

variable "iam_instance_profile" {
  type        = string
  description = "(Required) IAM instance profile"
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

variable "node_arch" {
  type        = string
  description = "(Required) Node architecture"
}

variable "node_label" {
  type        = string
  description = "(Required) Node label"
}

variable "node_type" {
  type        = string
  description = "(Required) Node type"
}

variable "os_version" {
  type        = string
  description = "(Required) OS version of base image"
}

variable "security_group_ids" {
  type        = list(string)
  description = "(Required) Security group IDs"
}

variable "verbose_logging" {
  type        = bool
  default     = false
  description = "(Optional) Enable verbose logging for Ansible"
}