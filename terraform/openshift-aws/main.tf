provider "aws" {
  region = "eu-north-1"
}

#################################
# ENIs
#################################

resource "aws_network_interface" "enis" {
  for_each = var.instances

  subnet_id       = "subnet-0b00b43a13acdb448"
  private_ips     = [each.value.private_ip]
  security_groups = ["sg-0aad32212ee911474"]
  tags = {
    Name = "${each.key}-eni"
  }
}

#################################
# EC2 INSTANCES
#################################

resource "aws_instance" "nodes" {
  for_each = var.instances

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interface {
    network_interface_id = aws_network_interface.enis[each.key].id
    device_index         = 0
  }

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }

  user_data = each.value.user_data
}