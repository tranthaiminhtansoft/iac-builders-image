source "amazon-ebs" "ami" {
  instance_type = var.ec2_instance_type
  region        = var.ec2_region
  
  ami_users   = local.shared_accounts[var.environment]
  ami_regions = local.shared_regions[var.environment]

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

  tags = local.common_tags
}