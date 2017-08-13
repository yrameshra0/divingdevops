resource "aws_instance" "flash" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"

    provisioner "local-exec" {
        command = "echo ${aws_instance.flash.private_ip} >> private_ips.txt"
    }
}

output "ip" {
    value = "${aws_instance.flash.public_ip}"
}