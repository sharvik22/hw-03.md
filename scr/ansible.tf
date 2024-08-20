resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",

    { 
      webservers =  yandex_compute_instance.vm_web, 
      databases  =  yandex_compute_instance.db_server,
      storage    =  [yandex_compute_instance.storage_server] 
    }
    
    )

  filename = "${abspath(path.module)}/hosts.cfg"
}