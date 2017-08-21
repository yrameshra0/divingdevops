variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = "map"

  default = {
    ap-south-1 = "ami-47205e28"
  }
}
