build {
  name = "iac-builders-ami"
  source "source.amazon-ebs.ami" {
    force_deregister      = var.enabled_force_deregister
    force_delete_snapshot = var.enabled_force_delete_snapshot

    ami_name        = var.image_name
    ami_description = var.image_description

    iam_instance_profile = var.iam_instance_profile

    source_ami_filter {
      virtualization_type = "hvm"
      name                = "ubuntu/images/*ubuntu-*-${var.os_version}-amd64-server-*"
      root_device_type    = "ebs"
    }
    max_retries = 5
  }
  
}