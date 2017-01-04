resource "aws_instance" "node-instance" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.node-securitygroup.id}"]

  # user data
  user_data = "${data.template_cloudinit_config.cloudinit-web.rendered}"

}

data "template_file" "pm2_process_conf" {
  template = "${file("${path.module}/templates/processes.tpl")}"
}
