resource "aws_instance" "control_hub" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "justice_league"

  # VPC Subnet
  subnet_id = "${aws_subnet.justice_league_public_1.id}"

  # Security Groups
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_public.id}"]

  provisioner "file" {
    source      = "${var.PRIVATE_KEY_FILE_PATH}"
    destination = "/tmp/justice_league.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/justice_league.pem /home",
    ]
  }

  tags {
    Name = "control_hub"
  }

  connection {
    user        = "${var.INSTANCE_USER}"
    private_key = "${file("${var.PRIVATE_KEY_FILE_PATH}")}"
  }
}

output "ip" {
  value = "${aws_instance.control_hub.public_ip}"
}

resource "aws_instance" "for_web" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "justice_league"

  # VPC Subnet
  subnet_id = "${aws_subnet.justice_league_private_1.id}"

  # Security Groups
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_private.id}"]

  tags {
    Name = "for_web"
  }
}

resource "aws_instance" "for_service" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "justice_league"

  # VPC Subnet
  subnet_id = "${aws_subnet.justice_league_private_1.id}"

  # Security Groups
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_private.id}"]

  tags {
    Name = "for_service"
  }
}

resource "aws_instance" "for_database" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "justice_league"

  # VPC Subnet
  subnet_id = "${aws_subnet.justice_league_private_1.id}"

  # Security Groups
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_private.id}"]

  tags {
    Name = "for_database"
  }
}
