resource "yandex_compute_disk" "default_disk" {
  count      = var.disk_count
  name       = "default-disk-${count.index + 1}"
  type       = var.disk_type
  zone       = var.default_zone
  size       = var.disk_size
  block_size = var.disk_block_size
}

resource "yandex_compute_instance" "storage_server" {
  depends_on = [yandex_compute_disk.default_disk]

  name        = var.vm_name
  platform_id = var.vm_platform_id

  resources {
    cores         = var.web_base.cores
    memory        = var.web_base.memory
    core_fraction = var.web_base.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = toset(yandex_compute_disk.default_disk[*].id)
    content {
      disk_id     = secondary_disk.value
      auto_delete = true
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = merge(local.ssh_key, {
    fqdn = "${var.vm_name}.ru-central1.internal"
  })
  
}