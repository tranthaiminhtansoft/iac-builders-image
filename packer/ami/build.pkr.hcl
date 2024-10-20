build {
  source = ["source.amazon-ebs.ami"]

  provisioner "ansible" {
    playbook_file    = "../../ansible/${var.node_label}-${replace(var.os_version, ".", "")}-playbook.yml"
    extra_arguments  = ["-v", ""]
    ansible_env_vars = ["ANSIBLE_STDOUT_CALLBACK=debug", "ANSIBLE_COLOR=True"]
  }
}