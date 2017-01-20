resource "aws_elb" "node_elb" {
  name            = "node-elb"
  subnets         = ["${aws_subnet.node_vpc_public_subnet.id}", "${aws_subnet.node_vpc_private_subnet.id}"]
  security_groups = ["${aws_security_group.node_elb_security_group.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }

  #instances = ["${aws_instance.node_instance.id}"]

  tags {
    Name = "${var.APP}_elb"
  }
}

resource "aws_security_group" "node_elb_security_group" {
  name        = "${var.APP}_elb"
  description = "Security group for ELB"
  vpc_id      = "${aws_vpc.node_vpc.id}"

  # Port open on ingress is open on egress as well. So no need to define it again
  # Only EC2 in private subnet can connect to ELB on http
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.node_vpc_private_subnet_cidr}", "0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.node_vpc_private_subnet_cidr}", "0.0.0.0/0"]
  }

  # Once SSL certificate is imported to ACM
  #  # Rest of the world can connect to ELB on https only
  #  ingress {
  #      from_port = 443
  #      to_port = 443
  #      protocol = "tcp"
  #      cidr_blocks = ["0.0.0.0/0"]
  #  }
  #  egress {
  #      from_port = 443
  #      to_port = 443
  #      protocol = "tcp"
  #      cidr_blocks = ["0.0.0.0/0"]
  #  }
  tags {
    Name = "${var.APP}_elb_security_group"
  }
}

output "node_elb_dns" {
  value = "${aws_elb.node_elb.dns_name}"
}
