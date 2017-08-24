variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = "map"

  default {
    ap-south-1 = "ami-47205e28"
  }
}

variable "PRIVATE_KEY_FILE_PATH" {
  default = "justice_league.pem"
}

variable "INSTANCE_USER" {
  default = "ec2-user"
}
