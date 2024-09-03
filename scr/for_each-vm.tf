resource "yandex_compute_instance" "db_server" {

  for_each = var.virtual_machines

  name        = each.value.vm_name
  resources {
    cores         = each.value.vm_cpu
    memory        = each.value.vm_ram
    core_fraction = each.value.vm_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.vm_disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = merge(local.ssh_key, {
    fqdn = "${each.value.vm_name}.ru-central1.internal"
  })
  
}
