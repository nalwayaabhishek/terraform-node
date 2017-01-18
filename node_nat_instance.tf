# NAT instance[public subnet] so that private subnet could connect to internet

resource "aws_instance" "node_nat_instance" {
  ami                         = "${var.node_nat_instance_ami}"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.node_nat_security_group.id}"]
  subnet_id                   = "${aws_subnet.node_vpc_public_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags {
    Name = "${var.APP}_nat_instance"
  }
}

# Security group for NAT instance[public subnet] which private subnet can connect through http or https only

resource "aws_security_group" "node_nat_security_group" {
  name        = "${var.APP}_nat_security_group"
  description = "Allows resources in private subnet to connect to NAT instance"
  vpc_id      = "${aws_vpc.node_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.node_vpc_private_subnet_cidr}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.node_vpc_private_subnet_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.APP}_nat_security_group"
  }
}

# Elastic IP for NAT  
resource "aws_eip" "node_nat_eip" {
  instance = "${aws_instance.node_nat_instance.id}"
  vpc      = true
}
