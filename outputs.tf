# OUTPUTS

output "vm_public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = azurerm_linux_virtual_machine.stcv.*.public_ip_address
}

output "vm_private_ip" {
  description = "List of private IP addresses assigned to the instances, if applicable"
  value       = azurerm_linux_virtual_machine.stcv.*.private_ip_address
}

output "id" {
  description = "List of IDs of instances"
  value       = azurerm_linux_virtual_machine.stcv.*.id
}