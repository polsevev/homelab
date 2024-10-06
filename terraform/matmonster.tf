resource "proxmox_vm_qemu" "matmonster" {
    name = "matmonster"
    desc = "Feed the beast server"
    target_node = "hermes"
  
    agent = 1
    onboot = true

    clone = "VM 9004"
    cores = 4
    sockets = 1
    cpu = "host"
    memory = 8192

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
                    size            = "20G"
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
    ipconfig0 = "ip=192.168.1.30/24,gw=192.168.1.1"
    nameserver = "192.168.1.69"
    ciuser = "ansible"
    sshkeys = var.ssh_public_key
}