#Security Group for Bastion
resource "aws_security_group" "SG-Bastion" {

  vpc_id = "${aws_vpc.main.id}"
  name = "SG-Bastion"

tags {
    Name = "SG-Bastion"
  }
}

resource "aws_security_group_rule" "Bastion-ingress_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.SG-Bastion.id}"
}

resource "aws_security_group_rule" "Bastion-egress_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.SG-Bastion.id}"
}

#Security Group for Web
resource "aws_security_group" "SG-Web" {

  vpc_id = "${aws_vpc.main.id}"
  name = "SG-Web"

tags {
    Name = "SG-Web"
  }
}

resource "aws_security_group_rule" "Web-ingress_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.SG-Bastion.id}"
  security_group_id = "${aws_security_group.SG-Web.id}"
}

resource "aws_security_group_rule" "Web-ingress_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.SG-Web.id}"
}

resource "aws_security_group_rule" "Web-egress_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.SG-Web.id}"
}