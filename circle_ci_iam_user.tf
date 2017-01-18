# This user is required for circle to automatically push the artifacts to S3 bucket and
# then call codedeploy for deployment. This user has 
# 1. Write access to a particular S3 bucket
# 2. Full Access of a particular codedeploy resource

data "template_file" "codedeploy_full_access"{
    template = "${file("${path.module}/templates/policies/codedeploy_full_access.tpl")}"
}
data "template_file" "s3_write_access"{
    template = "${file("${path.module}/templates/policies/s3_write_access.tpl")}"
    vars{
      s3_bucket_name = "${var.s3_bucket_name}"
    }
}

resource "aws_iam_user" "circleci" {
    name = "circleci"
    path = "/"
}

resource "aws_iam_access_key" "circleci" {
    user = "${aws_iam_user.circleci.name}"
}

resource "aws_iam_user_policy" "codedeploy_full_access"{
    name = "codedeploy_full_access"
    user = "${aws_iam_user.circleci.name}"
    policy = "${data.template_file.codedeploy_full_access.rendered}"
}

resource "aws_iam_user_policy" "s3_write_access" {
    name = "s3_write_access"
    user = "${aws_iam_user.circleci.name}"
    policy = "${data.template_file.s3_write_access.rendered}"
}

output "circle-access-key"{
  value = "${aws_iam_access_key.circleci.id}"
}

output "circle-secret-access-key"{
  value = "${aws_iam_access_key.circleci.secret}"
}
