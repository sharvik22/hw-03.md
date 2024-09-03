###cloud vars
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

variable "cloud_id" {
  type        = string
  default     = "b1gt70j0m7f1iiflddo3"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gg8ip2ck0ivpgo1nr6"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

# main and replica
variable "virtual_machines" {
  type = map(object({
    vm_name          = string
    vm_cpu           = number
    vm_ram           = number
    vm_disk_size     = number
    vm_core_fraction = number
  }))
  default = {
    "db1" = { vm_name = "main", vm_cpu = 2, vm_ram = 1, vm_disk_size = 5, vm_core_fraction = 5 },
    "db2" = { vm_name = "replica", vm_cpu = 2, vm_ram = 1, vm_disk_size = 10, vm_core_fraction = 20 }
  }
  description = "virtual machines main and replica"
}

#web-1 web-2
variable "web_base" {
  type = map(any)
  default = {
    cores         = 2,
    memory        = 1,
    core_fraction = 5,
    image_family  = "ubuntu-2004-lts"
  }
}

# New variables for disk_vm.tf
variable "disk_count" {
  type        = number
  default     = 3
  description = "Number of disks to create"
}

variable "disk_size" {
  type        = number
  default     = 1
  description = "Size of each disk in GB"
}

variable "disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Type of the disk"
}

variable "disk_block_size" {
  type        = number
  default     = 4096
  description = "Block size of the disk"
}

variable "vm_name" {
  type        = string
  default     = "storage"
  description = "Name of the storage VM"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for the VM"
}