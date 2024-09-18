variable "proxmox_api_url" {
  description = "URL du Node pve"
  type        = string
}

variable "ssh_public_key_path" {
  description = "path of ssh key"
  type        = string
}

variable "api_token" {
  description = "Token to connect Proxmox API"
  type        = string
}

variable "proxmox_user" {
  description = "User for authentication"
  type        = string
}

variable "proxmox_user_password" {
  description = "Password for user authentication"
  type        = string
}