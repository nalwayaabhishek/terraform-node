resource "aws_cloudwatch_metric_alarm" "node_asg_memory_high" {
  alarm_name          = "memory_high_${var.APP}_asg"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 memory for high utilization on ${var.APP} instances"
  alarm_actions       = ["${aws_autoscaling_policy.node_asg_scale_up.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.node_asg.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "node_asg_memory_low" {
  alarm_name          = "memory_low_${var.APP}_asg"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = 300
  statistic           = "Average"
  threshold           = 40
  alarm_description   = "This metric monitors ec2 memory for low utilization on ${var.APP} instances"
  alarm_actions       = ["${aws_autoscaling_policy.node_asg_scale_down.arn}"]

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.node_asg.name}"
  }
}
