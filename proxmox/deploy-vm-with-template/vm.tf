resource "proxmox_virtual_environment_vm" "terraform-vm" {
  name            = "terraform-vm"
  node_name       = "pve1"
  vm_id           = 2024
  bios            = "seabios" # put same bios that template
  stop_on_destroy = true
  template = false
  #timeout_create = 180
  

  agent {
    enabled = true
  }

  initialization {
    datastore_id = "local-zfs"
    interface = "ide2"

    ip_config {
      ipv4 {
        address = "192.168.1.160/24"
        gateway = "192.168.1.254"
      }
    }

    dns {
      servers = ["1.1.1.1", "8.8.8.8"]
    }

    user_account {
      username = "ubuntu"
      password = "ubuntu"
    }
  }

  clone {
    datastore_id = "local-zfs"
    full         = true
    vm_id        = "9000"
  }


  cpu {
    cores = 2
    numa  = true
    limit = 64
    # affinity = "0-1"
  }

  memory {
    dedicated = 2048
    # hugepages = "2"
  }

  efi_disk {
    datastore_id = "local-zfs"
    file_format  = "raw"
    type         = "4m"
  }

  disk {
    datastore_id = "local-zfs"
    file_format  = "raw"
    discard      = "on"
    interface    = "scsi0"
    size         = 20
  }


  # Network config
  network_device {
    model  = "virtio"
    bridge = "vmbr0"
  }

}