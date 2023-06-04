

resource "aws_s3_bucket" "week21-state-mc" {
  bucket = var.bucket_name

}
resource "aws_s3_bucket_ownership_controls" "backend_state_owner_controls" {
  bucket = aws_s3_bucket.week21-state-mc.id
  rule {
    object_ownership = "ObjectWriter"
  }
}