resource "aws_ebs_volume" "shared"{
  availability_zone = "${aws_instance.node-instance.availability_zone}"
  size = 4 
  tags {
    Name = "Shared drive"
  }
}

resource "aws_volume_attachment" "shared" {
  device_name = "/dev/sdh"
  volume_id = "${aws_ebs_volume.shared.id}"
  instance_id = "${aws_instance.node-instance.id}"
}