variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "ap-south-1"
}
variable "AMIS" {
    type = "map"
    default = {
        ap-south-1 = "ami-47205e28"
        us-east-1 = "ami-13be557e"
    }
}
variable "PUBLIC_KEY_FILE_PATH" {
    default = "justice_league.pub"
}
variable "INSTANCE_USERNAME" {
    default = "ec2-user"
}
variable "PRIVATE_KEY_FILE_PATH" {
    default = "justice_league"
}