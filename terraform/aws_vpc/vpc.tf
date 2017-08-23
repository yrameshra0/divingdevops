# Internet VPC

resource "aws_vpc" "justice_league" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "justice_league"
  }
}

# Subnets

resource "aws_subnet" "justice_league_public_1" {
  vpc_id                  = "${aws_vpc.justice_league.id}"
  cidr_block              = "10.10.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1a"

  tags {
    Name = "justice_league_public_1"
  }
}

resource "aws_subnet" "justice_league_public_2" {
  vpc_id                  = "${aws_vpc.justice_league.id}"
  cidr_block              = "10.10.20.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1b"

  tags {
    Name = "justice_league_public_2"
  }
}

resource "aws_subnet" "justice_league_private_1" {
  vpc_id                  = "${aws_vpc.justice_league.id}"
  cidr_block              = "10.10.40.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags {
    Name = "justice_league_private_1"
  }
}

resource "aws_subnet" "justice_league_private_2" {
  vpc_id                  = "${aws_vpc.justice_league.id}"
  cidr_block              = "10.10.50.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1b"

  tags {
    Name = "justice_league_private_2"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "justice_league_gw" {
  vpc_id = "${aws_vpc.justice_league.id}"

  tags {
    Name = "justice_league_gw"
  }
}

# Route Tables

resource "aws_route_table" "justice_league_public" {
  vpc_id = "${aws_vpc.justice_league.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.justice_league_gw.id}"
  }

  tags {
    Name = "justice_league_public"
  }
}

# Route Associations Public

resource "aws_route_table_association" "justice_league_public_1_a" {
  subnet_id      = "${aws_subnet.justice_league_public_1.id}"
  route_table_id = "${aws_route_table.justice_league_public.id}"
}

resource "aws_route_table_association" "justice_league_public_1_b" {
  subnet_id      = "${aws_subnet.justice_league_public_2.id}"
  route_table_id = "${aws_route_table.justice_league_public.id}"
}
