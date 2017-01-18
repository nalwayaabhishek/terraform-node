resource "aws_s3_bucket" "node_s3_bucket" {
    bucket = "${var.s3_bucket_name}"
    acl = "private"

    tags {
        Name = "${var.s3_bucket_name}"
    }
}
