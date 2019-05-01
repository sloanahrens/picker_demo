output "VPC ID" {
  value = "${aws_vpc.default.id}"
}

//

output "Production Public (b)" {
  value = "${aws_subnet.production-public-b.id}"
}
output "Production Public (c)" {
  value = "${aws_subnet.production-public-c.id}"
}
output "Production Private (b)" {
  value = "${aws_subnet.production-private.id}"
}

//

output "Staging Public (b)" {
  value = "${aws_subnet.staging-public-b.id}"
}
output "Staging Public (c)" {
  value = "${aws_subnet.staging-public-c.id}"
}
output "Staging Private (b)" {
  value = "${aws_subnet.staging-private.id}"
}