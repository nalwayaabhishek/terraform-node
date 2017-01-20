# Main WebServer[private subnet]

resource "aws_launch_configuration" "node_launch_config" {
  name_prefix          = "${var.APP}_launch_config_"
  image_id             = "${lookup(var.AMIS, var.region)}"
  instance_type        = "t2.micro"
  security_groups      = ["${aws_security_group.node_security_group.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ec2_s3_read_access.name}"
  key_name             = "${aws_key_pair.node_ssh_key.key_name}"
  enable_monitoring    = false
  user_data            = "${data.template_cloudinit_config.node_bootstrap.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "node_security_group" {
  name        = "${var.APP}_security_group"
  description = "Security group for node server"
  vpc_id      = "${aws_vpc.node_vpc.id}"

  # Bastion instances[public subnet] can ssh into node_instance.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.node_vpc_public_subnet_cidr}"]
  }

  # For ELB to connect to the instance & to download packages via NAT instance
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.node_vpc_public_subnet_cidr}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.node_vpc_public_subnet_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.APP}_security_group"
  }
}
