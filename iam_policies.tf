data "template_file" "s3_full_access"{
    template = "${path.module}/templates/s3_full_access.tpl"
    vars{
        bucket_name = "${aws_s3_bucket.S3_BUCKET.bucket}"
    }
}
data "template_file" "codedeploy_full_access"{
    template = "${path.module}/templates/codedeploy_full_access.tpl"
}

data "template_file" "ec2_trust_policy"{
    template = "${path.module}/templates/ec2_trust_policy.tpl"
}
resource "aws_iam_policy" "s3_full_access" {
  name = "s3_full_access"
  path = "/"
  description = "Give read and write access to all s3 buckets"
  policy = "${data.template_file.s3_full_access.rendered}"
}
