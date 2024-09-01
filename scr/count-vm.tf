resource "yandex_compute_instance" "vm_web" {
  count       = 2
  name        = "web-${count.index + 1}"
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
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = var.sec_group
  }
  metadata = var.metadata_all

depends_on = [
    yandex_compute_instance.db_server
  ]

}
