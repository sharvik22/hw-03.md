locals {
  ssh_key = {
    ssh-keys           = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    serial-port-enable = "1"
  }
}
