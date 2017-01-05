resource "aws_s3_bucket" "S3_BUCKET" {
    bucket = "${var.S3_BUCKET}"
    acl = "private"

    tags {
        Name = "${var.S3_BUCKET}"
        Environment = "test"
    }
}
