resource "aws_alb" "app" {
  name = "app-alb-${var.stack_name}"
  internal        = false
  subnets         = ["${var.app_public_subnet_b_id}","${var.app_public_subnet_c_id}"]
  security_groups = ["${aws_security_group.app.id}"]

  tags {
    Stack = "${var.stack_name}"
  }
}

resource "aws_alb_target_group" "app_target_group_http" {
  name     = "${var.stack_name}-app-http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.master_vpc_id}"

  health_check {
    path = "/elb-status"
    protocol = "HTTP"
    port = 80
  }

  tags {
    Stack = "${var.stack_name}"
  }
}

resource "aws_alb_target_group" "app_target_group_https" {
  name     = "${var.stack_name}-app-https"
  port     = 1443
  protocol = "HTTP"
  vpc_id   = "${var.master_vpc_id}"

  health_check {
    path = "/elb-status"
    protocol = "HTTP"
    port = 80
  }

  tags {
    Stack = "${var.stack_name}"
  }
}

resource "aws_alb_listener" "http" {
   depends_on = ["aws_alb_target_group.app_target_group_https"]
   load_balancer_arn = "${aws_alb.app.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
     target_group_arn = "${aws_alb_target_group.app_target_group_http.arn}"
     type = "forward"
   }
}

resource "aws_alb_listener" "https" {
   depends_on = ["aws_alb_target_group.app_target_group_https"]
   load_balancer_arn = "${aws_alb.app.arn}"
   port = "443"
   protocol = "HTTPS"
   certificate_arn = "${var.ssl_certificate}"

   default_action {
     target_group_arn = "${aws_alb_target_group.app_target_group_https.arn}"
     type = "forward"
   }
}

resource "aws_alb_listener_rule" "http" {
  depends_on = ["aws_alb_target_group.app_target_group_http"]
  listener_arn = "${aws_alb_listener.http.arn}"
  priority = 1

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.app_target_group_http.arn}"
  }

  condition {
    field = "path-pattern"
    values = ["/*"]
  }
}

resource "aws_alb_listener_rule" "https" {
  depends_on = ["aws_alb_target_group.app_target_group_https"]
  listener_arn = "${aws_alb_listener.https.arn}"
  priority = 1

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.app_target_group_https.arn}"
  }

  condition {
    field = "path-pattern"
    values = ["/*"]
  }
}
