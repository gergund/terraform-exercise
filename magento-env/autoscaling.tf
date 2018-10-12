resource "aws_launch_configuration" "launchconfig" {
  name_prefix          = "launchconfig"
  image_id             = "ami-00035f41c82244dab"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykeypair.key_name}"
  security_groups      = ["${aws_security_group.SG-Web.id}"]

  lifecycle { 
	create_before_destroy = true 
  }

}

resource "aws_autoscaling_group" "autoscaling" {
  name                 = "autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.main-private-1a.id}", "${aws_subnet.main-private-1b.id}"]
  launch_configuration = "${aws_launch_configuration.launchconfig.name}"
  min_size             = 1
  desired_capacity     = 1
  max_size             = 4
  health_check_grace_period = 300
  health_check_type = "ELB"
  load_balancers = ["${aws_elb.my-elb.name}"]
  force_delete = true

  lifecycle {
    create_before_destroy = true
  }

  tag {
      key = "Name"
      value = "web"
      propagate_at_launch = true
  }
}

