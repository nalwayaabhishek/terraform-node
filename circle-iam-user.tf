resource "aws_iam_user" "circleci" {
    name = "circleci"
    path = "/"
}

resource "aws_iam_access_key" "circleci" {
    user = "${aws_iam_user.circleci.name}"
}

resource "template_file" "s3_w"{
    filename = "${path.module}/templates/s3_w.tpl"
    vars{
        bucket_name = "${aws_s3_bucket.S3_BUCKET.bucket}"
    }
}
resource "template_file" "codedeploy_full_access"{
    filename = "${path.module}/templates/codedeploy_full_access.tpl"
}

resource "aws_iam_user_policy" "codedeploy_full_access"{
    name = "codedeploy_full_access"
    user = "${aws_iam_user.circleci.name}"
    policy = "${template_file.codedeploy_full_access.rendered}"
}

resource "aws_iam_user_policy" "s3_w" {
    name = "s3_w"
    user = "${aws_iam_user.circleci.name}"
    policy = "${template_file.s3_w.rendered}"
}
