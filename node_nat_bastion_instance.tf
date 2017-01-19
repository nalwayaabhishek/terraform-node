# NAT instance[public subnet] so that private subnet could connect to internet

resource "aws_instance" "node_nat_bastion_instance" {
  ami                         = "${var.node_nat_bastion_instance_ami}"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.node_ssh_key.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.node_nat_bastion_security_group.id}"]
  subnet_id                   = "${aws_subnet.node_vpc_public_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags {
    Name = "${var.APP}_nat_bastion_instance"
  }
}

# Security group for NAT instance[public subnet] which private subnet can connect through http or https only

resource "aws_security_group" "node_nat_bastion_security_group" {
  name        = "${var.APP}_nat_bastion_security_group"
  description = "Allows resources in private subnet to connect to NAT instance. Acts as a bastion host as well"
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
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Anyone can ssh into bastion host(omit with your ip). It can only ssh into intances in private subnet
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.node_vpc_private_subnet_cidr}"]
  }

  tags {
    Name = "${var.APP}_nat_bastion_security_group"
  }
}

# outputting NAT/Bastion public IP for ssh-ing into node_instance via bastion host
output "nat_bastion_host_ip" {
  value = "${aws_instance.node_nat_bastion_instance.public_ip}"
}
