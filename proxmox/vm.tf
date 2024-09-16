resource "proxmox_virtual_environment_vm" "terraform-vm" {
  name      = "terraform-vm"
  node_name = "pve1"
 # migrate   = true // migrate the VM on node change
  vm_id     = 2024

  bios = "ovmf"
  stop_on_destroy = true

  agent {
    enabled = true
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

  # Config cdrom for iso
  cdrom {
    enabled   = true
    file_id   = "local:iso/debian-12.5.0-amd64-netinst.iso" 
    interface = "ide2"
  }

  # Network config
  network_device {
    model  = "virtio"
    bridge = "vmbr0"
  }

}