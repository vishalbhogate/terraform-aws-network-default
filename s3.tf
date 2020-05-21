resource "aws_s3_bucket" "default" {
  bucket = "mumbai-terraform-backend"
  region = "ap-south-1"
  acl    = "private"

  tags = merge(
    var.tags,
    {
      "Name"    = "${var.name}-S3Bucket"
      "Scheme"  = "backend"
      "EnvName" = var.name
    }
  )
}
