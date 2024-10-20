data "git-commit" "cwd-head" {}
data "git-repository" "cwd" {}

locals {
  ansible_verbosity = var.verbose_logging ? "-vvv" : "-v"

  common_tags = merge({
    Branch      = data.git-repository.cwd.branches[0]
    Commit      = data.git-commit.cwd-head.hash
    Environment = var.environment
    Lifetime    = local.lifetime["${var.environment}"]
    Packer      = "true"
    Repo        = data.git-repository.cwd.head
  }, var.additional_tags)

  lifetime = {
    "dev"     = var.lifetime_tag != "" ? var.lifetime_tag : "relative-days-7"
    "staging" = var.lifetime_tag != "" ? var.lifetime_tag : "relative-months-1"
    "prod"    = var.lifetime_tag != "" ? var.lifetime_tag : "relative-months-3"
  }

  shared_accounts = {
    dev     = [],
    staging = [],
    prod    = []
  }

  shared_regions = {
    dev     = [],
    staging = [],
    prod    = []
  }
}