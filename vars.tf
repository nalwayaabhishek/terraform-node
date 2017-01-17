variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "node_ssh_public_key" {
  default = "mykey.pub"
}

variable "s3_bucket_name"{
  default = "generation-test"
}
variable "deployment_group"{
  default = "production-group"
}

variable "APP"{
  default = "generation"
}

variable "node_nat_instance_ami"{
  default = "ami-184dc970"
}
variable "node_vpc_cidr"{
  default = "10.0.0.0/16"
}
variable "node_vpc_public_subnet_cidr"{
  default = "10.0.1.0/24"
}
variable "node_vpc_private_subnet_cidr"{
  default = "10.0.2.0/24"
}
variable "node_vpc_public_subnet_az"{
  default = "us-east-1b"
}
variable "node_vpc_private_subnet_az"{
  default = "us-east-1d"
}

variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-e13739f6"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}
