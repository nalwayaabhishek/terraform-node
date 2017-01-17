# Template files present in templates/policies 

# EC2 trust policy required to be appended to role for EC2

data "template_file" "ec2_trust_policy"{
    template = "${file("${path.module}/templates/policies/ec2_trust_policy.tpl")}"
}

# Passing bucket name so as to make only that bucket accessible by resources to whom this policy will be attached

data "template_file" "s3_read_access"{
    template = "${file("${path.module}/templates/policies/s3_read_access.tpl")}"
    vars{
        s3_bucket_name = "${var.s3_bucket_name}"
    }
}

# Creating iam policy to read from s3 bucket

resource "aws_iam_policy" "s3_read_access" {
  name = "s3_read_access"
  path = "/"
  description = "Gives read access to s3 bucket specified"
  policy = "${data.template_file.s3_read_access.rendered}"
}

# Creating a role for EC2 instance

resource "aws_iam_role" "ec2_s3_read_access" {
  name      = "ec2_s3_read_access"
  path      = "/"
  assume_role_policy = "${data.template_file.ec2_trust_policy.rendered}"
}

# Attaching S3 read policy to EC2 role created above

resource "aws_iam_role_policy_attachment" "ec2_s3_read_access" {
  role = "${aws_iam_role.ec2_s3_read_access.name}"
  policy_arn = "${aws_iam_policy.s3_read_access.arn}"
}

# Creating iam instance profile with the role to be appended to node_instance

resource "aws_iam_instance_profile" "ec2_s3_read_access" {
  name = "ec2_s3_read_access"
  roles = ["${aws_iam_role.ec2_s3_read_access.name}"]
}
