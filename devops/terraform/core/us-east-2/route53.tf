resource "aws_route53_zone" "internal" {
   name = "pickerint.net"
   vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route53_record" "queue" {
  depends_on = ["aws_instance.queue"]
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name = "queue.pickerint.net"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.queue.private_ip}"]
}

resource "aws_route53_record" "vpn" {
  depends_on = ["aws_instance.vpn"]
  zone_id = "${var.public_route53_zone_id}"
  name = "vpn-${var.aws_region}.sloanahrens.com"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.vpn.public_ip}"]
}