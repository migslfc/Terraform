terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "example-org-d8898b"

    workspaces {
      name = "Week22-Project"
    }
  }
}