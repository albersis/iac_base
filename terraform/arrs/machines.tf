resource "proxmox_lxc" "machines" {
  target_node  = "proxboxbig"
  hostname     = "radarr"
  ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  password     = "Orange1r"
  unprivileged = false
  cores = 2
  memory = 2048
  swap = 512
  hastate = "started"


  rootfs {
    storage = "local-lvm"
    size    = "16G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.4.2/24"
    gw = "192.168.4.1"
  }

  ssh_public_keys = <<-EOT
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANwVQrieNSv4bKU2X8pwn3zhiXHKQL2EWk8FG2bQqZN
  EOT

}