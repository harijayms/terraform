variable "resource_group" {
  description = "The name of the resource group in which to create the virtual network."
}

variable "location1" {
  description = "Location where first VNET, Gateway, PublicIP and Connection will be deployed."
  default     = "southcentralus"
}

variable "location2" {
  description = "Location where second VNET, Gateway, PublicIP and Connection will be deployed."
  default     = "centralus"
}

variable "vnet_name_1" {
  description = "Name of the first VNET."
  default     = "vnet1"
}

variable "address_prefix_1" {
  description = "Address space for the first VNET."
  default     = "192.168.100.0/24"
}

variable "subnet1_name_1" {
  description = "Name of the first subnet in the first VNET. Please note, an additional subnet called GatewaySubnet will be created where the VirtualNetworkGateway will be deployed. The name of that subnet must not be changed from GatewaySubnet."
  default     = "vnet1subnet1"
}

variable "subnet_prefix_1" {
  description = "The prefix for the first subnet in the first VNET."
  default     = "192.168.100.0/28"
}

variable "gateway_subnet_prefix_1" {
  description = "The prefix for the GatewaySubnet where the first VirtualNetworkGateway will be deployed. This must be at least /29."
  default     = "192.168.100.16/28"
}

variable "gateway_pip_name_1" {
  description = "The name of the PublicIP attached to the first Virtual Network Gateway. Must be unique."
}

variable "gateway_name_1" {
  description = "The name of the first Virtual Network Gateway."
  default     = "vnet1gw"
}

variable "connection_name_1" {
  description = "The name of the first connection, connecting the first Virtual Network Gateway to the second Virtual Network Gateway."
  default     = "vnet1connection"
}

variable "vnet_name_2" {
  description = "Name of the second VNET."
  default     = "vnet2"
}

variable "address_prefix_2" {
  description = "Address space for the second VNET."
  default     = "192.168.101.0/24"
}

variable "subnet1_name_2" {
  description = "Name of the first subnet in the second VNET. Please note, an additional subnet called GatewaySubnet will be created where the Virtual Network Gateway will be deployed. The name of that subnet must not be changed from GatewaySubnet."
  default     = "vnet2subnet1"
}

variable "subnet1_prefix_2" {
  description = "The prefix for the first subnet in the second VNET."
  default     = "192.168.101.0/28"
}

variable "gateway_subnet_prefix_2" {
  description = "The prefix for the Gateway Subnet where the second Virtual Network Gateway will be deployed. This must be at least /29."
  default     = "192.168.101.16/28"
}

variable "gateway_pip_name_2" {
  description = "The name of the Public IP attached to the second Virtual Network Gateway. Must be unique."
}

variable "gateway_name_2" {
  description = "The name of the second Virtual Network Gateway."
  default     = "vnet2gw"
}

variable "connection_name_2" {
  description = "The name of the second connection, connecting the second Virtual Network Gateway to the first Virtual Network Gateway."
  default     = "vnet2connection"
}

variable "shared_key" {
  description = "The shared key used to establish connection between the two Virtual Network Gateways."
}
