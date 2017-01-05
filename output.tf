output "node-ip" {
  value = "${aws_instance.node-instance.public_ip}"
}
output "elb-dns"{
  value = "${aws_elb.node-elb.dns_name}"
}
output "circle-access-key"{
  value = "${aws_iam_access_key.circleci.id}"
}
output "circle-secret-access-key"{
  value = "${aws_iam_access_key.circleci.secret}"
}
