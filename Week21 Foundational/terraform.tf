

terraform {
  backend "s3" {
    bucket = "week21-state-mc"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}