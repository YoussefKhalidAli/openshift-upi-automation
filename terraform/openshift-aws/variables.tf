variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "volume_size" {}

variable "instances" {
  type = map(object({
    private_ip      = string
    security_groups = list(string)
    user_data       = string
  }))
}