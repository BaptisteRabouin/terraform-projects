terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.64.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_api_url
  #username = var.proxmox_user
  #password = var.proxmox_user_password
  api_token = var.api_token
  insecure  = true

  ssh {
    agent = true
  }
}
