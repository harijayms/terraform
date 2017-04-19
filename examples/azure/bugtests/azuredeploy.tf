resource "azurerm_resource_group" "rtTableTests" {
    name = "acctest429-5"
    location = "West US"
}
 
resource "azurerm_virtual_network" "rtTable2" {
    name = "acctestvirtnet"
    address_space = ["10.0.0.0/16"]
    location = "West US"
    resource_group_name = "${azurerm_resource_group.rtTableTests.name}"
    tags {
                                  environment = "Testing"
                  }
}
 
resource "azurerm_subnet" "rtTable2" {
    name = "acctestsubnet"
    resource_group_name = "${azurerm_resource_group.rtTableTests.name}"
    virtual_network_name = "${azurerm_virtual_network.rtTable2.name}"
    address_prefix = "10.0.2.0/24"
                route_table_id       = "${azurerm_route_table.rtTable2.id}"
}
 
resource "azurerm_route_table" "rtTable2" {
  name                = "rtTable2-RT"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.rtTableTests.name}"
}
 
resource "azurerm_route" "route_a" {
  name                = "TestRouteA"
  resource_group_name = "${azurerm_resource_group.rtTableTests.name}"
  route_table_name    = "${azurerm_route_table.rtTable2.name}"
 
  address_prefix         = "10.100.0.0/14"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.10.1.1"
}