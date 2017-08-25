# Creating AWS instance to play around with ansible

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "instance1" {
  ami           = "ami-47205e28"
  instance_type = "t2.micro"
  key_name      = "justice_league"

  provisioner "file" {
    source      = "justice_league.pem"
    destination = "/tmp/justice_league.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/justice_league.pem",
      "sudo mv /tmp/justice_league.pem /home/ec2-user",
      "sudo yum upgrade -y",
      "sudo pip install ansible",
    ]
  }

  connection {
    user        = "ec2-user"
    private_key = "${file("justice_league.pem")}"
  }

  tags {
    Name = "instance1"
  }

  provisioner "local-exec" {
    command = "echo INSTANCE1 HOSTNAME -- ${aws_instance.instance1.private_dns} >> output.txt && echo INSTANCE1 HOSTNAME -- ${aws_instance.instance1.public_ip} >> output.txt"
  }
}

resource "aws_instance" "instance2" {
  ami           = "ami-47205e28"
  instance_type = "t2.micro"
  key_name      = "justice_league"

  tags {
    Name = "instance2"
  }

  provisioner "local-exec" {
    command = "echo INSTANCE2 HOSTNAME -- ${aws_instance.instance2.private_dns} >> output.txt"
  }
}
