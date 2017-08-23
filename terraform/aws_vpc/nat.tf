# Network Access Translation

resource "aws_eip" "justice_league_nat" {
  vpc = true
}

resource "aws_nat_gateway" "justice_league_nat_gw" {
  allocation_id = "${aws_eip.justice_league_nat.id}"
  subnet_id     = "${aws_subnet.justice_league_public_1.id}"
  depends_on    = ["aws_internet_gateway.justice_league_gw"]
}

# VPC setup for NAT

resource "aws_route_table" "justice_league_private" {
  vpc_id = "${aws_vpc.justice_league.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.justice_league_nat_gw.id}"
  }

  tags {
    Name = "justice_league_private"
  }
}

# Route Associations Private

resource "aws_route_table_association" "justice_league_private_1_a" {
  subnet_id      = "${aws_subnet.justice_league_private_1.id}"
  route_table_id = "${aws_route_table.justice_league_private.id}"
}

resource "aws_route_table_association" "justice_league_private_1_b" {
  subnet_id      = "${aws_subnet.justice_league_private_2.id}"
  route_table_id = "${aws_route_table.justice_league_private.id}"
}
