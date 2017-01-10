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

resource "aws_iam_user_policy" "s3_full_access" {
    name = "s3_full_access"
    user = "${aws_iam_user.circleci.name}"
    policy = "${data.template_file.s3_full_access.rendered}"
}
