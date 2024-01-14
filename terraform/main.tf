resource "proxmox_vm_qemu" "k3_vm" {
  for_each = { for key, value in var.k3_vm : key => value.count }

  name        = "${each.value.name}-${each.key + 1}"
  target_node = "pve1"
  vmid        = "${each.value.vmid}${each.key + 1}"
  clone       = "debian11-genericcloud-template"
  full_clone  = true
  agent       = 1
  os_type     = "cloud-init"
  cores       = each.value.cores
  sockets     = each.value.sockets
  cpu         = "host"
  memory      = each.value.memory
  scsihw      = "virtio-scsi-pci"
  disk {
    slot    = 0
    size    = each.value.disk_size
    type    = "scsi"
    storage = "local-lvm"
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  network {
    model  = "virtio"
    bridge = "vmbr17"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=${each.value.ingress_network_config.base_ip}${each.key + 1}${each.value.ingress_network_config.cidr},gw=${each.value.ingress_network_config.gateway}"
  ipconfig1 = "ip=${each.value.cluster_network_config.base_ip}${each.key + 1}${each.value.cluster_network_config.cidr}"
  sshkeys   = <<EOF
  ${tls_private_key.ssh_key.public_key_openssh}
  EOF
}
