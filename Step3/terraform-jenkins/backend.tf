terraform {
  backend "s3" {
   bucket = "my-tf-state-hw22"
    key    = "jenkins/terraform.tfstate"
    region = "eu-central-1"
  }
}