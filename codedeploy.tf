resource "aws_codedeploy_app" "deployer" {
  name = "deployer"
}

resource "aws_codedeploy_deployment_group" "deployer_group" {
  app_name              = "${aws_codedeploy_app.deployer.name}"
  deployment_group_name = "${var.deployment_group}"
  service_role_arn      = "${aws_iam_role.codedeploy_ec2_tag_access_role.arn}"

  ec2_tag_filter {
    key   = "Name"
    type  = "KEY_AND_VALUE"
    value = "${var.APP}"
  }
}
