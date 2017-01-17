# Codedeploy needs access to tags & EC2 instances as it searches EC2 instance via tags.

data "template_file" "codedeploy_trust_policy"{
  template = "${file("${path.module}/templates/policies/codedeploy_trust_policy.tpl")}"
}

data "template_file" "ec2_tag_access_policy"{
  template = "${file("${path.module}/templates/policies/ec2_tag_access_policy.tpl")}"
}

resource "aws_iam_role" "codedeploy_ec2_tag_access_role" {
    name = "codedeploy_ec2_tag_access_role"
    assume_role_policy = "${data.template_file.codedeploy_trust_policy.rendered}"
}

resource "aws_iam_role_policy" "codedeploy_ec2_tag_access_policy" {
    name = "codedeploy_ec2_tag_access_policy"
    role = "${aws_iam_role.codedeploy_ec2_tag_access_role.id}"
    policy = "${data.template_file.ec2_tag_access_policy.rendered}"
}
