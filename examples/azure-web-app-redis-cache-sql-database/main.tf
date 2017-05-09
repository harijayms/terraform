# provider "azurerm" {
#   subscription_id = "REPLACE-WITH-YOUR-SUBSCRIPTION-ID"
#   client_id       = "REPLACE-WITH-YOUR-CLIENT-ID"
#   client_secret   = "REPLACE-WITH-YOUR-CLIENT-SECRET"
#   tenant_id       = "REPLACE-WITH-YOUR-TENANT-ID"
# }

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "azurerm_sql_server" "server" {
  name                         = "${var.resource_group}-sqlsvr"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "${var.admin_username}"
  administrator_login_password = "${var.admin_password}"
}

resource "azurerm_sql_firewall_rule" "fw" {
  name                = "AllowAllWindowsAzureIPs"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_sql_server.server.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_database" "db" {
  name                             = "${var.resource_group}-db"
  resource_group_name              = "${azurerm_resource_group.rg.name}"
  location                         = "${var.location}"
  edition                          = "${var.edition}"
  collation                        = "${var.collation}"
  create_mode                      = "Default"
  requested_service_objective_name = "${var.requested_service_objective_name}"
  server_name                      = "${azurerm_sql_server.server.name}"
  max_size_bytes                   = "${var.max_size_bytes}"
}

# "name": "[variables('hostingPlanName')]",
# "type": "Microsoft.Web/serverfarms",
# "location": "[resourceGroup().location]",
# "tags": {
  # "displayName": "HostingPlan"
# },
# "sku": {
  # "name": "[parameters('skuName')]",
  # "capacity": "[parameters('skuCapacity')]"
# },
# "properties": {
  # "name": "[variables('hostingPlanName')]"
# }

# "name": "[variables('webSiteName')]",
# "type": "Microsoft.Web/sites",
# "location": "[resourceGroup().location]",
# "dependsOn": [
#   "[concat('Microsoft.Web/serverFarms/', variables('hostingPlanName'))]",
#   "[concat('Microsoft.Cache/Redis/', variables('cacheName'))]"
# ],
# "tags": {
#   "[concat('hidden-related:', resourceGroup().id, '/providers/Microsoft.Web/serverfarms/', variables('hostingPlanName'))]": "empty",
#   "displayName": "Website"
# },

# "properties": {
#   "name": "[variables('webSiteName')]",
#   "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('hostingPlanName'))]"
# },
# "type": "config",
# "name": "connectionstrings",
# "dependsOn": [
#   "[concat('Microsoft.Web/Sites/', variables('webSiteName'))]",
#   "[concat('Microsoft.Sql/servers/', variables('sqlserverName'))]"
# ],

# "properties": {
#   "TeamContext": {
#     "value": "[concat('Data Source=tcp:', reference(concat('Microsoft.Sql/servers/', variables('sqlserverName'))).fullyQualifiedDomainName, ',1433;Initial Catalog=', parameters('databaseName'), ';User Id=', parameters('administratorLogin'), '@', variables('sqlserverName'), ';Password=', parameters('administratorLoginPassword'), ';')]",
#  "type": "SQLServer"
# "type": "config",
# "name": "appsettings",
# "dependsOn": [
#   "[concat('Microsoft.Web/Sites/', variables('webSiteName'))]",
#   "[concat('Microsoft.Cache/Redis/', variables('cacheName'))]"

# "properties": {
#   "CacheConnection": "[concat(variables('cacheName'),'.redis.cache.windows.net,abortConnect=false,ssl=true,password=', listKeys(resourceId('Microsoft.Cache/Redis', variables('cacheName')), '2015-08-01').primaryKey)]"

resource "azurerm_redis_cache" "redis" {
  name                = "${var.resource_group}-redis"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  capacity            = "${var.cache_sku_capacity}"
  family              = "${var.cache_sku_family}"
  sku_name            = "${var.cache_sku_name}"
  enable_non_ssl_port = false

  redis_configuration {
    maxclients = "256"
  }
}
