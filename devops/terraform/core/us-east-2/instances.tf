resource "aws_instance" "vpn" {
  ami      = "${var.vpn_ami}"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.master-public.id}"
  key_name      = "${var.key_name}"
  user_data     = "${file("terraform/user_data/user_data.sh")}"
  vpc_security_group_ids = ["${aws_security_group.vpn.id}"]

  tags {
    Name = "Master VPN"
    class = "vpn"
    stack = "master"
  }
}


resource "aws_instance" "queue" {
  ami      = "${var.queue_ami}"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.master-private.id}"
  key_name      = "${var.key_name}"
  user_data     = "${file("terraform/user_data/user_data.sh")}"
  vpc_security_group_ids = ["${aws_security_group.queue.id}"]

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

  tags {
    Name = "Master Queue"
    class = "queue"
    stack = "master"
  }
}

