resource "proxmox_vm_qemu" "havneboks" {
    name = "havneboks"
    desc = "Docker master"
    target_node = "poseidon"
  
    agent = 1
    onboot = true

    clone = "VM 9001"
    cores = 4
    sockets = 1
    cpu = "host"
    memory = 3096

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
    ipconfig0 = "ip=192.168.1.51/24,gw=192.168.1.1"
    nameserver = "192.168.1.69"
    ciuser = "ansible"
    sshkeys = var.ssh_public_key
}