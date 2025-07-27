resource "aws_s3_bucket" "state_bucket" {
  bucket              = "moabodaif-terraform-bucket"
  bucket_prefix       = null
  force_destroy = true
}
