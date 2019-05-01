resource "aws_autoscaling_group" "app-asg" {
  lifecycle { create_before_destroy = true }

  name                 = "${var.stack_name} - App Autoscaling Group (${aws_launch_configuration.app-lc.name})"
  max_size             = "1"
  min_size             = "1"
  desired_capacity     = "1"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.app-lc.name}"
  target_group_arns    = ["${aws_alb_target_group.app_target_group_http.arn}","${aws_alb_target_group.app_target_group_https.arn}"]
  vpc_zone_identifier  = ["${var.app_private_subnet_id}"]

  tag {
    key                 = "Name"
    value               = "${var.stack_name} :: App Node"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "class"
    value               = "app"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "stack"
    value               = "${var.stack_name}"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "app-lc" {
  lifecycle { create_before_destroy = true }

  image_id      = "${var.app_ami}"
  instance_type = "${var.app_instance_size}"
  user_data       = <<EOF
#!/bin/bash
sleep 30
sudo ansible-playbook -s -i 'localhost,' /ops/picker_demo/devops/ansible/mb-django-init.yml --extra-vars 'ec2_region=${var.aws_region} stack_name=${var.stack_name}'
EOF
  associate_public_ip_address = false
  key_name        = "${var.key_name}"
  security_groups = ["${aws_security_group.app.id}","${aws_security_group.default.id}"]
}

//

resource "aws_autoscaling_group" "worker-asg" {
  lifecycle { create_before_destroy = true }

  name                 = "${var.stack_name} - Worker Autoscaling Group (${aws_launch_configuration.worker-lc.name})"
  max_size             = "1"
  min_size             = "1"
  desired_capacity     = "1"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.worker-lc.name}"
  vpc_zone_identifier  = ["${var.app_private_subnet_id}"]

  tag {
    key                 = "Name"
    value               = "${var.stack_name} :: Worker Node"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "class"
    value               = "worker"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "stack"
    value               = "${var.stack_name}"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "worker-lc" {
  lifecycle { create_before_destroy = true }

  image_id      = "${var.worker_ami}"
  instance_type = "${var.worker_instance_size}"
  associate_public_ip_address = false
  key_name        = "${var.key_name}"
  security_groups = ["${aws_security_group.default.id}"]
}