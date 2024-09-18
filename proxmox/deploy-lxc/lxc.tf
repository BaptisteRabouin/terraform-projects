resource "proxmox_virtual_environment_container" "debian_container" {
  description   = "Managed by Terraform"
  node_name     = "pve1"
  start_on_boot = true
  tags          = ["test"]
  unprivileged  = true
  vm_id         = 666

  cpu {
    architecture = "amd64"
    cores        = 1
  }

  disk {
    datastore_id = "local-zfs"
    size         = 8
  }

  memory {
    dedicated = 1024
    swap      = 0
  }
# If the template is already upload, if not put URL
  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
    type             = "debian"
  }

  initialization {
    hostname = "terraform-lxc"

    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.1.160/24"
        gateway = "192.168.1.254"
      }
    }
    user_account {
      #keys     = ["put-your-ssh-pubkey-here"]
      password = "test1"
    }
  }
  network_interface {
    name       = "vmbr0"
    rate_limit = 10
  }

  features {
    nesting = true
    fuse    = false
  }
}