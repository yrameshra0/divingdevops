resource "aws_key_pair" "justice_league" {
    key_name = "justice_league"
    public_key = "${file("${var.PUBLIC_KEY_FILE_PATH}")}"
}

resource "aws_instance" "thor" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.justice_league.key_name}"

    provisioner "file" {
        source = "script.sh"
        destination = "/tmp/script.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/script.sh",
            "sudo /tmp/script.sh"
        ]
    }

    connection {
        user = "${var.INSTANCE_USERNAME}"
        private_key = "${file("${var.PRIVATE_KEY_FILE_PATH}")}"
    }
}