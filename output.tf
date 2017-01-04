output "node-ip" {
  value = "${aws_instance.node-instance.public_ip}"
  value = "${aws_elb.node-elb.dns_name}"
}
