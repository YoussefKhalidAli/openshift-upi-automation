variable "ami" {}
variable "key_name" {}
variable "volume_size" {
  default = 120
}

variable "instances" {
  type = map(object({
    private_ip      = string
    security_groups = list(string)
    user_data       = string
    instance_type   = string
  }))
}