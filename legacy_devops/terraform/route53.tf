resource "aws_route53_record" "app-public" {
  zone_id = "${var.public_route53_zone_id}"
  name = "${var.stack_name}"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_alb.app.dns_name}"]
}