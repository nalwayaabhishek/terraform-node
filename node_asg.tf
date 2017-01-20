resource "aws_autoscaling_group" "node_asg" {
  name                      = "${var.APP}_asg_group"
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = ["${aws_subnet.node_vpc_private_subnet.id}"]
  launch_configuration      = "${aws_launch_configuration.node_launch_config.id}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  load_balancers            = ["${aws_elb.node_elb.id}"]

  tag {
    key                 = "Name"
    value               = "${var.APP}"
    propagate_at_launch = true
  }
}

# ASG actions to be called upon cloudwatch alarms

resource "aws_autoscaling_policy" "node_asg_scale_up" {
  name                   = "${var.APP}_asg_scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.node_asg.name}"
}

resource "aws_autoscaling_policy" "node_asg_scale_down" {
  name                   = "${var.APP}_asg_scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.node_asg.name}"
}
