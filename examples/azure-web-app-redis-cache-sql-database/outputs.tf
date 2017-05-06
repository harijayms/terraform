output "hostname" {
  value = "${var.hostname}"
}

output "vm_fqdn" {
  value = "${azurerm_public_ip.lbpip.fqdn}"
}

output "sshCommand" {
  value = "ssh ${var.admin_username}@${azurerm_public_ip.lbpip.fqdn}"
}
