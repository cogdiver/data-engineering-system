# S3 Bucket
resource "aws_s3_bucket" "default" {
  bucket = "${var.project_name_base}-storage"
}
