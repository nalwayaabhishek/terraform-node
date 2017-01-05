output "node-ip" {
  value = "${aws_instance.node-instance.public_ip}"
}
output "elb-dns"{
  value = "${aws_elb.node-elb.dns_name}"
}
