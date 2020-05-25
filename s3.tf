/* resource "aws_s3_bucket" "default" {
  bucket = var.bucket_name
  region = "ap-south-1"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-S3Bucket"
      "Scheme"  = "backend"
      "EnvName" = var.name
    }
  )
}
 */