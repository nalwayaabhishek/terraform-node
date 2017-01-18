resource "aws_key_pair" "node_ssh_key" {
  key_name   = "${var.APP}_ssh_key"
  public_key = "${file("${var.node_ssh_public_key}")}"

  lifecycle {
    ignore_changes = ["public_key"]
  }
}
