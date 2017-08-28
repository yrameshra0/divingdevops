# Creating AWS instance to play around with ansible

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "control_hub" {
  ami           = "ami-3c374c53"
  instance_type = "t2.micro"
  key_name      = "justice_league"

  provisioner "file" {
    source      = "justice_league.pem"
    destination = "/tmp/justice_league.pem"
  }

  provisioner "file" {
    source      = "plays"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = "demo"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install software-properties-common",
      "sudo apt-add-repository ppa:ansible/ansible -y",
      "sudo apt udpate",
      "sudo apt-get install ansible -y",
      "sudo apt update",
              "sudo apt upgrade -y",
      "sudo mv /tmp/plays /home/ubuntu",
      "sudo mv /tmp/demo /home/ubuntu/plays/",
      "sudo mv /tmp/justice_league.pem /home/ubuntu",
      "sudo chmod 400 /home/ubuntu/justice_league.pem",
    ]
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("justice_league.pem")}"
  }

  tags {
    Name = "control_hub"
  }
}

output "control_hub_public_ip" {
  value = "${aws_instance.control_hub.public_ip}"
}

output "control_hub_private_ip" {
  value = "${aws_instance.control_hub.private_ip}"
}

resource "aws_instance" "instance" {
  count         = 2
  ami           = "ami-3c374c53"
  instance_type = "t2.micro"
  key_name      = "justice_league"

  tags {
    Name = "instance-${count.index}"
  }
}

output "instances_private_ips" {
  value = ["${aws_instance.instance.*.private_ip}"]
}
