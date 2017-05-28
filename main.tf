provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"
}

resource "aws_subnet" "public" {
  count = "${var.public_subnet_count}"

  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${cidrsubnet(var.cidr_block, var.subnet_bit_size, var.public_subnet_count)}"

  tags {
    visibility = "public"
  }
}

resource "aws_subnet" "private" {
  count = "${var.private_subnet_count}"

  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${cidrsubnet(var.cidr_block, var.subnet_bit_size, var.public_subnet_count + var.private_subnet_count)}"

  tags {
    visibility = "private"
  }
}
