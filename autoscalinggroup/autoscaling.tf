resource "aws_launch_configuration" "launchconfig" {
  name_prefix          = "launchconfig"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykeypair.key_name}"
  security_groups      = ["${aws_security_group.SG-Web.id}"]
}

resource "aws_autoscaling_group" "autoscaling" {
  name                 = "autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.main-private-1a.id}", "${aws_subnet.main-private-1b.id}"]
  launch_configuration = "${aws_launch_configuration.launchconfig.name}"
  min_size             = 1
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true

  tag {
      key = "Name"
      value = "web"
      propagate_at_launch = true
  }
}

