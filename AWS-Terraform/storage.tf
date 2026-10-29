resource "aws_s3_bucket" "my_bucket" {
  bucket = "indian-terraform-bucket"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}