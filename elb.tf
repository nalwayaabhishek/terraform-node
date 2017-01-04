resource "aws_elb" "node-elb" {
  name = "node-elb"
  availability_zones = ["us-east-1b","us-east-1c","us-east-1d"]
  listener{
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check{
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }
  instances = ["${aws_instance.node-instance.id}"]
}
