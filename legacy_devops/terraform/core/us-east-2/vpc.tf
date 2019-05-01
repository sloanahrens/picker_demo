resource "aws_vpc" "default" {
  cidr_block = "10.${var.ip_class_b}.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  
  tags {
    Name = "Master"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id = "${aws_subnet.master-public.id}"
  depends_on = ["aws_internet_gateway.default"]
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route" "private_nat_gateway_route" {
  route_table_id = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  depends_on = ["aws_route_table.private"]
  nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
}

resource "aws_route_table_association" "private-nat-master" {
    subnet_id = "${aws_subnet.master-private.id}"
    route_table_id = "${aws_route_table.private.id}"
}


// Production NAT

resource "aws_route_table_association" "private-nat-production" {
    subnet_id = "${aws_subnet.production-private.id}"
    route_table_id = "${aws_route_table.private.id}"
}


// Staging NAT

resource "aws_route_table_association" "private-nat-staging" {
    subnet_id = "${aws_subnet.staging-private.id}"
    route_table_id = "${aws_route_table.private.id}"
}