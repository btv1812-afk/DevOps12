resource "aws_s3_bucket" "tf_state" {
  bucket = "my-tf-state-hw22" 

  force_destroy = true

  tags = {
    Name = "Terraform State"
  }
}
