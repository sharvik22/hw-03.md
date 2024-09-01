locals {
  virtual_machines = {
    "db1" = { vm_name = "main", vm_cpu = 2, vm_ram = 1, vm_disk_size = 5, vm_core_fraction = 5 },
    "db2" = { vm_name = "replica", vm_cpu = 2, vm_ram = 1, vm_disk_size = 10, vm_core_fraction = 20 }
  }

ssh_key = {
    ssh-keys           = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    serial-port-enable = 1
  }
}