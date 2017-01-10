resource "aws_iam_role" "ec2_s3_full_access" {
  name      = "ec2_s3_full_access"
  path      = "/"
  assume_role_policy = "${data.template_file.ec2_trust_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "ec2_s3_full_access" {
  role = "${aws_iam_role.ec2_s3_full_access.name}"
  policy_arn = "${aws_iam_policy.s3_full_access.arn}"
}

resource "aws_iam_instance_profile" "ec2_s3_full_access" {
  name = "ec2_s3_full_access"
  roles = ["${aws_iam_role.ec2_s3_full_access.name}"]
}
