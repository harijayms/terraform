# provider "azurerm" {
#   subscription_id = "REPLACE-WITH-YOUR-SUBSCRIPTION-ID"
#   client_id       = "REPLACE-WITH-YOUR-CLIENT-ID"
#   client_secret   = "REPLACE-WITH-YOUR-CLIENT-SECRET"
#   tenant_id       = "REPLACE-WITH-YOUR-TENANT-ID"
# }

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group}"
  location = "${var.location1}"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.vnet_name_1}"
  location            = "${var.location1}"
  address_space       = ["${var.address_prefix_1}"]
  resource_group_name = "${azurerm_resource_group.rg.name}"

  subnet {
    name           = "${var.subnet1_name_1}"
    address_prefix = "${var.subnet_prefix_1}"
  }
}

# Would this go in the vnet1 block once a vnet gateway and connection resource are created?
resource "azurerm_subnet" "gw1" {
  name                 = "GatewaySubnet"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefix       = "${var.gateway_subnet_prefix_1}"
}

# Would this go in the vnet gateway block once a vnet gateway and connection resource are created?
resource "azurerm_public_ip" "gw1" {
  name                         = "${var.gateway_pip_name_1}"
  location                     = "${var.location1}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "Dynamic"
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "${var.vnet_name_2}"
  location            = "${var.location2}"
  address_space       = ["${var.address_prefix_2}"]
  resource_group_name = "${azurerm_resource_group.rg.name}"

  subnet {
    name           = "${var.subnet1_name_2}"
    address_prefix = "${var.subnet_prefix_2}"
  }
}

# Would this go in the vnet2 block once a vnet gateway and connection resource are created?
resource "azurerm_subnet" "gw2" {
  name                 = "GatewaySubnet"
  virtual_network_name = "${azurerm_virtual_network.vnet2.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefix       = "${var.gateway_subnet_prefix_2}"
}

# Would this go in the vnet gateway block once a vnet gateway and connection resource are created?
resource "azurerm_public_ip" "gw2" {
  name                         = "${var.gateway_pip_name_2}"
  location                     = "${var.location2}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "Dynamic"
}

# Stopping now until unblocked by the resource creation.
        #     "type": "Microsoft.Network/virtualNetworkGateways",
        #     "name": "[parameters('gatewayName1')]",
        #     "location": "[parameters('location1')]",
        #     "dependsOn": [
        #         "[concat('Microsoft.Network/publicIPAddresses/', parameters('gatewayPublicIPName1'))]",
        #         "[concat('Microsoft.Network/virtualNetworks/', parameters('virtualNetworkName1'))]"
        #     ],
        #     "properties": {
        #         "ipConfigurations": [
        #             {
        #                 "properties": {
        #                     "privateIPAllocationMethod": "Dynamic",
        #                     "subnet": {
        #                         "id": "[variables('gatewaySubnetRef1')]"
        #                     },
        #                     "publicIPAddress": {
        #                         "id": "[resourceId('Microsoft.Network/publicIPAddresses',parameters('gatewayPublicIPName1'))]"
        #                     }
        #                 },
        #                 "name": "vnetGatewayConfig1"
        #             }
        #         ],
        #         "gatewayType": "Vpn",
        #         "vpnType": "RouteBased",
        #         "enableBgp": "false"
        #     }
        # },
        # {
        #     "apiVersion": "[variables('apiVersion')]",
        #     "type": "Microsoft.Network/virtualNetworkGateways",
        #     "name": "[parameters('gatewayName2')]",
        #     "location": "[parameters('location2')]",
        #     "dependsOn": [
        #         "[concat('Microsoft.Network/publicIPAddresses/', parameters('gatewayPublicIPName2'))]",
        #         "[concat('Microsoft.Network/virtualNetworks/', parameters('virtualNetworkName2'))]"
        #     ],
        #     "properties": {
        #         "ipConfigurations": [
        #             {
        #                 "properties": {
        #                     "privateIPAllocationMethod": "Dynamic",
        #                     "subnet": {
        #                         "id": "[variables('gatewaySubnetRef2')]"
        #                     },
        #                     "publicIPAddress": {
        #                         "id": "[resourceId('Microsoft.Network/publicIPAddresses',parameters('gatewayPublicIPName2'))]"
        #                     }
        #                 },
        #                 "name": "vnetGatewayConfig2"
        #             }
        #         ],
        #         "gatewayType": "Vpn",
        #         "vpnType": "RouteBased",
        #         "enableBgp": "false"
        #     }
        # },
        # {
        #     "apiVersion": "[variables('apiVersion')]",
        #     "type": "Microsoft.Network/connections",
        #     "name": "[parameters('connectionName1')]",
        #     "location": "[parameters('location1')]",
        #     "dependsOn": [
        #         "[concat('Microsoft.Network/virtualNetworkGateways/', parameters('gatewayName1'))]",
        #         "[concat('Microsoft.Network/virtualNetworkGateways/', parameters('gatewayName2'))]"
        #     ],
        #     "properties": {
        #         "virtualNetworkGateway1": {
        #             "id": "[resourceId('Microsoft.Network/virtualNetworkGateways',parameters('gatewayName1'))]"
        #         },
        #         "virtualNetworkGateway2": {
        #             "id": "[resourceId('Microsoft.Network/virtualNetworkGateways',parameters('gatewayName2'))]"
        #         },
        #         "connectionType": "Vnet2Vnet",
        #         "routingWeight": 3,
        #         "sharedKey": "[parameters('sharedKey')]"
        #     }
        # },
        # {
        #     "apiVersion": "[variables('apiVersion')]",
        #     "type": "Microsoft.Network/connections",
        #     "name": "[parameters('connectionName2')]",
        #     "location": "[parameters('location2')]",
        #     "dependsOn": [
        #         "[concat('Microsoft.Network/virtualNetworkGateways/', parameters('gatewayName1'))]",
        #         "[concat('Microsoft.Network/virtualNetworkGateways/', parameters('gatewayName2'))]"
        #     ],
        #     "properties": {
        #         "virtualNetworkGateway1": {
        #             "id": "[resourceId('Microsoft.Network/virtualNetworkGateways',parameters('gatewayName2'))]"
        #         },
        #         "virtualNetworkGateway2": {
        #             "id": "[resourceId('Microsoft.Network/virtualNetworkGateways',parameters('gatewayName1'))]"
        #         },
        #         "connectionType": "Vnet2Vnet",
        #         "routingWeight": 3,
        #         "sharedKey": "[parameters('sharedKey')]"
        #     }
        # }