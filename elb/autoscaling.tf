resource "aws_launch_configuration" "launchconfig" {
  name_prefix          = "launchconfig"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykeypair.key_name}"
  security_groups      = ["${aws_security_group.SG-Web.id}"]
  user_data            = "#!/bin/bash\napt-get update\napt-get -y install nginx\nMYIP=`ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
  lifecycle              { create_before_destroy = true }
}

resource "aws_autoscaling_group" "autoscaling" {
  name                 = "autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.main-private-1a.id}", "${aws_subnet.main-private-1b.id}"]
  launch_configuration = "${aws_launch_configuration.launchconfig.name}"
  min_size             = 2
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  load_balancers = ["${aws_elb.my-elb.name}"]
  force_delete = true

  tag {
      key = "Name"
      value = "web"
      propagate_at_launch = true
  }
}

