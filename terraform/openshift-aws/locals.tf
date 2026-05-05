locals {
  instances = {

    "openshift-infra0" = {
      private_ip      = "10.0.1.100"
      security_groups = ["sg-0aad32212ee911474"]
      instance_type   = "t3.large"
      ign             = var.workerign
    }

    "openshift-master0" = {
      private_ip      = "10.0.1.101"
      security_groups = ["sg-0aad32212ee911474"]
      instance_type   = "t3.xlarge"
      ign             = var.masterign
    }

    "openshift-worker0" = {
      private_ip      = "10.0.1.200"
      security_groups = ["sg-0aad32212ee911474"]
      instance_type   = "t3.large"
      ign             = var.workerign
    }

    "openshift-worker1" = {
      private_ip      = "10.0.1.201"
      security_groups = ["sg-0aad32212ee911474"]
      instance_type   = "t3.large"
      ign             = var.workerign
    }

    "openshift-worker2" = {
      private_ip      = "10.0.1.202"
      security_groups = ["sg-0aad32212ee911474"]
      instance_type   = "t3.large"
      ign             = var.workerign
    }

    "openshift-worker3" = {
      private_ip      = "10.0.1.203"
      security_groups = ["sg-0aad32212ee911474"]
      instance_type   = "t3.large"
      ign             = var.workerign
    }

    "openshift-odf0" = {
      private_ip      = "10.0.1.222"
      security_groups = ["sg-0aad32212ee911474"]
      instance_type   = "t3.large"
      ign             = var.workerign
      ebs_block_device = {
        device_name           = "/dev/sdb"
        volume_size           = 200
        volume_type           = "gp3"
        delete_on_termination = true
      }
    }
  }
}