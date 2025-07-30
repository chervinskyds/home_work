
terraform {
  backend "s3" {
    bucket = "step3cds-terraform-state"
    key    = "jenkins/terraform.tfstate"
    region = "eu-central-1"
  }
}
