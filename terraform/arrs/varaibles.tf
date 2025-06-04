
variable "root_password" {
    type = string
    default = "password"
}

variable "ssh_public_key" {
    type = string
    default = "~/.ssh/id_ed25519.pub"
}