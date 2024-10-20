source "amazon-ebs" "ami" {
  ami_name        = "${var.node_label}-${var.node_type}-${var.node_arch}-${var.os_version}-${replace(var.ec2_instance_type, ".", "-")}"
  ami_description = var.image_description
  instance_type   = var.ec2_instance_type
  region          = var.ec2_region
  
  source_ami_filter {
    virtualization_type = "hvm"
    name                = "ubuntu/images/*ubuntu-*-${var.os_version}-amd64-server-*"
    root_device_type    = "ebs"
  }

  iam_instance_profile = var.iam_instance_profile
  
  user_data_file = "../../script/user_data.sh"
  ami_users      = local.shared_accounts[var.environment]
  snapshot_users = local.shared_accounts[var.environment]
  ami_regions    = local.shared_regions[var.environment]

  communicatior = "ssh"
  ssh_username  = "ubuntu"

  vpc_filter {
    filters = {
      "tag:Name" = "ami-bakery-dev*"
    }
  }

  subnet_filter {
    filters = {
      "tag:Name" = "ami-bakery-dev-private*"
    }
    most_free = true
  }

  force_deregister      = var.enabled_force_deregister
  force_delete_snapshot = var.enabled_force_delete_snapshot
  max_retries           = 5
  tags                  = local.common_tags
}