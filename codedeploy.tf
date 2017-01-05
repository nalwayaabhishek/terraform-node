resource "aws_codedeploy_app" "deployer" {
  name = "${var.APP}"
}
resource "aws_iam_role_policy" "deployer_policy" {
    name = "deployer_policy"
    role = "${aws_iam_role.deployer_role.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "tag:GetTags",
                "tag:GetResources",
                "s3:*",
                "iam:*",
                "codedeploy:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
resource "aws_iam_role" "deployer_role" {
    name = "deployer_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "codedeploy.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_codedeploy_deployment_group" "production-group" {
    app_name = "${aws_codedeploy_app.deployer.name}"
    deployment_group_name = "production-group"
    service_role_arn = "${aws_iam_role.deployer_role.arn}"

    ec2_tag_filter {
        key = "Name"
        type = "KEY_AND_VALUE"
        value = "${var.APP}"
    }
}
