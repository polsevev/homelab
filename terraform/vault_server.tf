resource "proxmox_vm_qemu" "postres" {
    name = "brevgress"
    desc = "Database server"
    target_node = "zeus"
  
    agent = 1
    onboot = true

    clone = "VM 9000"
    cores = 2
    sockets = 1
    cpu = "host"
    memory = 2048

    # Setup the disk
    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = "basseng"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size            = "10G"
                    storage         = "basseng"
                }
            }
        }
    }


    network {
      bridge = "vmbr0"
      model = "virtio"
    }
    scsihw = "virtio-scsi-pci"
    os_type = "cloud-init"
    ipconfig0 = "ip=192.168.1.70/24,gw=192.168.1.1"
    nameserver = "192.168.1.69"
    ciuser = "ansible"
    sshkeys = var.ssh_public_key
}