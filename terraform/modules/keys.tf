resource "aws_key_pair" "justice_league" {
    key_name = "justice_league"
    public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}