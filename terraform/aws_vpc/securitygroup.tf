resource "aws_security_group" "allow_ssh_public" {
  vpc_id      = "${aws_vpc.justice_league.id}"
  name        = "allow_ssh_public"
  description = "security group that allows ssh all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["182.48.236.89/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["182.19.55.237/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["223.227.40.9/32"]
  }
}

resource "aws_security_group" "allow_ssh_private" {
  vpc_id = "${aws_vpc.justice_league.id}"
  name   = "allow_ssh_private"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["10.10.0.0/16"]
  }
}
