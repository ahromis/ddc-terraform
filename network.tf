resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.env_name}-vpc"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_subnet" "public" {
  depends_on = ["aws_internet_gateway.default"]
  count = 3
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${lookup(var.public_cidrs, count.index%3)}"
  availability_zone = "${lookup(var.availability_zones, count.index%3)}"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.env_name}-public-subnet-${count.index}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

resource "aws_route_table_association" "public" {
  count = 3
  subnet_id = "${element(aws_subnet.public.*.id, count.index%3)}"
  route_table_id = "${aws_route_table.public.id}"
}

