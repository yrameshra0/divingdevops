module "consul" {
    source = "github.com/wardviaene/terraform-consul-module.git"
    key_name = "${aws_key_pair.justice_league.key_name}"
    key_path = "${var.PATH_TO_PRIVATE_KEY}"
}

output "console-output" {
    value = "${module.consul.server_address}"
}