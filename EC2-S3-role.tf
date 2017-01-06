resource "aws_iam_role" "EC2-S3-Full-Access" {
  name      = "EC2-S3-Full-Access"
  path      = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "template_file" "S3-Full-Access"{
  filename = "${path.module}/templates/s3_w.tpl"
}

resource "aws_iam_policy" "S3-Full-Access"{
  name = "S3-Full-Acess"
  path = "/"
  policy = "${template_file.s3_w.rendered}"
}

resource "aws_iam_role_policy_attachment" "EC2-S3-Attach" {
  role = "${aws_iam_role.EC2-S3-Full-Access.name}"
  policy_arn = "${aws_iam_policy.S3-Full-Access.arn}"
}

resource "aws_iam_instance_profile" "EC2-S3-Full-Access" {
  name = "EC2-S3-Full-Access-Profile"
  roles = ["${aws_iam_role.EC2-S3-Full-Access.name}"]
}
