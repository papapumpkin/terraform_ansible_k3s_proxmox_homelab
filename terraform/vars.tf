variable "pm_api_url" {
  type = string
}
variable "pm_api_token_id" {
  type = string
}
variable "pm_api_token_secret" {
  type      = string
  sensitive = true
}

variable "private_key_path" {
  type      = string
  sensitive = true
}

variable "public_key_path" {
  type      = string
  sensitive = true
}

variable "k3_vm" {
  type = map(object({
    name                   = string,
    count                  = number,
    disk_size              = string,
    memory                 = number,
    cores                  = number,
    sockets                = number,
    vmid                   = string,
    ingress_network_config = map(string),
    cluster_network_config = map(string)
  }))
}
