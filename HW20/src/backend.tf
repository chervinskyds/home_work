terraform {
  backend "s3" {
    bucket = "terraform-state-danit-devops-8"
    key    = "hw20/che-hw20/terraform.tfstate"
    region = "eu-central-1"
  }
}