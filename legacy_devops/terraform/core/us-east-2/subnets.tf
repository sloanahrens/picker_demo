//////
// Master Subnets
//////

resource "aws_subnet" "master-public" {
  availability_zone       = "${var.aws_region}b"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.${var.ip_class_b}.255.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Master - Public"
  }
}

resource "aws_subnet" "master-private" {
  availability_zone       = "${var.aws_region}c"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.${var.ip_class_b}.254.0/24"
  map_public_ip_on_launch = false

  tags {
    Name = "Master - Private"
  }
}

//////
// Production Subnets
//////

resource "aws_subnet" "production-public-b" {
  availability_zone       = "${var.aws_region}b"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.${var.ip_class_b}.10.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Production - Public (b)"
  }
}

resource "aws_subnet" "production-public-c" {
  availability_zone       = "${var.aws_region}c"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.${var.ip_class_b}.11.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Production - Public (b)"
  }
}

resource "aws_subnet" "production-private" {
  availability_zone       = "${var.aws_region}b"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.${var.ip_class_b}.12.0/24"
  map_public_ip_on_launch = false

  tags {
    Name = "Production - Private (b)"
  }
}

//////
// Staging Subnets
//////

resource "aws_subnet" "staging-public-b" {
  availability_zone       = "${var.aws_region}b"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.${var.ip_class_b}.20.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Staging - Public (b)"
  }
}

resource "aws_subnet" "staging-public-c" {
  availability_zone       = "${var.aws_region}c"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.${var.ip_class_b}.21.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Staging - Public (b)"
  }
}

resource "aws_subnet" "staging-private" {
  availability_zone       = "${var.aws_region}b"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.${var.ip_class_b}.22.0/24"
  map_public_ip_on_launch = false

  tags {
    Name = "Staging - Private (b)"
  }
}