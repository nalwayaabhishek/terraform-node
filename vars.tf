variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "ELB_AZS"{
  default = ["us-east-1b","us-east-1c","us-east-1d"]
}
variable "S3_BUCKET"{
  default = "generation-test"
}
variable "APP"{
  default = "generation"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-e13739f6"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}
