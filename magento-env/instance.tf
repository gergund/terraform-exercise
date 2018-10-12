resource "aws_instance" "bastion" {
  ami           = "ami-844e0bf7"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1a.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.SG-Bastion.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

  tags {
     	Name = "bastion"
  }
}

output "public_ip" {
    value = "${aws_instance.bastion.public_ip}"
}

output "private_ip" {
    value = "${aws_instance.bastion.private_ip}"
}


