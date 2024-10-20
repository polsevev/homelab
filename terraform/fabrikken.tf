resource "proxmox_vm_qemu" "fabrikken" {
    name = "fabrikken"
    desc = "Factorio VM"
    target_node = "hades"
  
    agent = 1
    onboot = true

    clone = "VM 9000"
    cores = 4
    sockets = 1
    cpu = "host"
    memory = 4096

    # Setup the disk
    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = "cronus_backup"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size            = "15G"
                    storage         = "maskin"
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
    ipconfig0 = "ip=192.168.1.31/24,gw=192.168.1.1"
    nameserver = "192.168.1.69"
    ciuser = "ansible"
    sshkeys = var.ssh_public_key
}