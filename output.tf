output "node-ip" {
  value = "${aws_instance.node-instance.public_ip}"
}
