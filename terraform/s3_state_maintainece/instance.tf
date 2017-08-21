resource "aws_instance" "batman" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
}
