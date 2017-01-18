# VPC components:
# 1. Public Subnet. node_vpc_public_subnet
#      a. Internet Gateway - Provides internet connectivity. Access to ELB from outside world. Access from NAT to outside world. node_igw
#      b. ELB - ELB over EC2 instances. node_elb
#      c. NAT instance - Interface for internet connection to EC2 in private subnet. Required for updating & installing packages. node_nat_instance
#      d. Bastion Host (optional) - Instance to ssh into EC2 instance in private subnet (for debugging purposes) 
# 2. Private Subnet. node_vpc_private_subnet
#      a. EC2 - Web Server. node_instance

resource "aws_vpc" "node_vpc" {
  cidr_block = "${var.node_vpc_cidr}"

  tags {
    Name = "${var.APP}_vpc"
  }
}

# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "node_igw" {
  vpc_id = "${aws_vpc.node_vpc.id}"

  tags {
    Name = "${var.APP}_igw"
  }
}

# Private and Public subnets for VPC

resource "aws_subnet" "node_vpc_public_subnet" {
  vpc_id            = "${aws_vpc.node_vpc.id}"
  availability_zone = "${var.node_vpc_public_subnet_az}"
  cidr_block        = "${var.node_vpc_public_subnet_cidr}"

  tags {
    Name = "${var.APP}_vpc_public_subnet"
  }
}

resource "aws_subnet" "node_vpc_private_subnet" {
  vpc_id            = "${aws_vpc.node_vpc.id}"
  availability_zone = "${var.node_vpc_private_subnet_az}"
  cidr_block        = "${var.node_vpc_private_subnet_cidr}"

  tags {
    Name = "${var.APP}_vpc_private_subnet"
  }
}

# Routing tables for public subnet. Public subnet can connect to internet gateway

resource "aws_route_table" "node_vpc_public_routes" {
  vpc_id = "${aws_vpc.node_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.node_igw.id}"
  }

  tags {
    Name = "${var.APP}_public_subnet_routes"
  }
}

resource "aws_route_table_association" "node_vpc_public_routes_attachment" {
  subnet_id      = "${aws_subnet.node_vpc_public_subnet.id}"
  route_table_id = "${aws_route_table.node_vpc_public_routes.id}"
}

# Routing tables for private subnet. Private subnet can connect to internet via NAT instance present in public subnet

resource "aws_route_table" "node_vpc_private_routes" {
  vpc_id = "${aws_vpc.node_vpc.id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.node_nat_instance.id}"
  }

  tags {
    Name = "${var.APP}_private_subnet_routes"
  }
}

resource "aws_route_table_association" "node_vpc_private_routes_attachment" {
  subnet_id      = "${aws_subnet.node_vpc_private_subnet.id}"
  route_table_id = "${aws_route_table.node_vpc_private_routes.id}"
}
