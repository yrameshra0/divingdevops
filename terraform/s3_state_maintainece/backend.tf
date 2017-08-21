terraform {
  backend "s3" {
    bucket = "terraform-state-diving"
    key    = "terraform/s3-state-maintained"
  }
}
