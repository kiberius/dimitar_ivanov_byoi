resource "aws_sns_topic" "cw_alarms" {
  name            = "SNS-CloudWatch-Sandbox"
  delivery_policy = file("./Monitoring-Policies/sns_delivery_policy.json")
}

data "aws_instances" "asg-instance-ids" {
  instance_tags = {
    Name = "ASG-sandbox"
  }
  instance_state_names = ["stopped", "running"]
}

data "aws_autoscaling_group" "ACG-sandbox" {
  name = "ACG-sandbox"
}

data "aws_launch_template" "LT-sandbox" {
  tags = {
    Name = "Launch_Template-sandbox"
  }
}

output "asg_instance_ids" {
  value = data.aws_instances.asg-instance-ids.ids
}

resource "aws_cloudwatch_metric_alarm" "cw-cpu-alarm" {
  count               = length(data.aws_instances.asg-instance-ids.ids)
  alarm_name          = "[BYOI]-[App-Instance]-[CPU]-${count.index}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    InstanceId = element(data.aws_instances.asg-instance-ids.ids, count.index)
  }
  alarm_actions = [aws_sns_topic.cw_alarms.arn]
  ok_actions    = [aws_sns_topic.cw_alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "cw-mem-alarm" {
  count               = length(data.aws_instances.asg-instance-ids.ids)
  alarm_name          = "[BYOI]-[App-Instance]-[Memory]-${count.index}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "mem_used_percent"
  namespace           = "Custom"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    InstanceId           = element(data.aws_instances.asg-instance-ids.ids, count.index)
#    AutoScalingGroupName = data.aws_autoscaling_group.ACG-sandbox.name
#    ImageId              = data.aws_launch_template.LT-sandbox.image_id
#    InstanceType         = data.aws_launch_template.LT-sandbox.instance_type
  }
  alarm_actions = [aws_sns_topic.cw_alarms.arn]
  ok_actions    = [aws_sns_topic.cw_alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "cw-disk-alarm" {
  count               = length(data.aws_instances.asg-instance-ids.ids)
  alarm_name          = "[BYOI]-[App-Instance]-[Disk]-${count.index}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "disk_used_percent"
  namespace           = "Custom"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    InstanceId           = element(data.aws_instances.asg-instance-ids.ids, count.index)
#    AutoScalingGroupName = data.aws_autoscaling_group.ACG-sandbox.name
#    ImageId              = data.aws_launch_template.LT-sandbox.image_id
#    InstanceType         = data.aws_launch_template.LT-sandbox.instance_type
    device               = "nvme0n1p1"
    path                 = "/"
    fstype               = "xfs"
  }
  alarm_actions = [aws_sns_topic.cw_alarms.arn]
  ok_actions    = [aws_sns_topic.cw_alarms.arn]
}