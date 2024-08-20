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

# metadata
variable "metadata_all" {
  type        = map(string)
  description = "ssh-keygen -t ed25519"
  default     = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGtGgCucF4rB9fJftdS3o6muoClGVjxpTDxhoY3AEkCI root@terraform"
  }
}

#sec_group
variable "sec_group" {
  description = "ID of the security group"
  type        = any
  default     = ["enps5mdemh53pt5sdnu8"]
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

