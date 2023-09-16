terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
    token = "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"
}

resource "github_repository" "terraformtest" {
  name        = "terraform_1"
  description = "terraform"

  visibility = "private"

}