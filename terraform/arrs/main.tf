
resource "proxmox_vm_qemu" "production" {
  target_node = "proxboxbig"
  name = "arrs"
  desc = "one of the arrs"

  onboot = true

  os_type = "cloud-init"
  clone = "ubuntu-cloud-24"
  full_clone = true

  agent = 1

  cores = 2
  sockets = 1
  cpu_type = "host"
  scsihw = "virtio-scsi-single"
  bootdisk = "scsi0"
  memory = 4096

  nameserver = "192.168.4.1"
  ipconfig0 = "ip=192.168.4.2/24,gw=192.168.4.1"
  #ipconfig0 = "ip=192.168.4.2${count.index + 1}/24,gw=192.168.4.1"
  #ipconfig0  = "ip=dhcp"
  skip_ipv6  = true

  network {
    bridge = "vmbr0"
    model = "virtio"
    id = 0
  }

  vga {
    type   = "std"
    memory = 512
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = "32G" 
        }
      }
    }
    ide {
      ide1 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

#  provisioner "remote-exec" {
#    inline = [
#      "ip a"
#    ]
#    connection {
#      type = "ssh"
#      user = "moob"
#      password =  var.root_password
#      private_key = var.ssh_private_key
#      private_key = "${file (var.ssh_private_key)}"
#      private_key = file(pathexpand(var.ssh_private_key))
#      host = "192.168.4.2"
#    }
#  }

  ciuser     = "moob"
  cipassword = var.root_password
  #ciupgrade = true
  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANwVQrieNSv4bKU2X8pwn3zhiXHKQL2EWk8FG2bQqZN
  EOF
}