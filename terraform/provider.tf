terraform {
    required_version = ">= 0.13.0"

    required_providers {
      proxmox = {
        source = "telmate/proxmox"
        version = "3.0.1-rc3"
      }
    }
}

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_user" {
    type = string
    sensitive = true
}

variable "proxmox_password" {
    type = string
    sensitive = true
}

variable "ssh_public_key" {
    type = string
}


provider "proxmox"{
    pm_api_url = var.proxmox_api_url
    pm_user = var.proxmox_user
    pm_password = var.proxmox_password
    pm_tls_insecure = true
    pm_otp = ""
}