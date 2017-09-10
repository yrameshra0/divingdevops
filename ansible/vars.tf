variable "INSTANCE_NAMES" {
  type = "map"

  default = {
    instance-0 = "loadbalancer-database"
    instance-1 = "webserver"
  }
}
