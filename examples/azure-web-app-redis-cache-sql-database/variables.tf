variable "resource_group" {
  description = "The name of the resource group in which to create the virtual network."
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "southcentralus"
}

variable "db_name" {
  description = "The name of the new database to create"
}

variable "sku_name" {
  description = "Describes plan's pricing tier and instance size. Check details at https://azure.microsoft.com/en-us/pricing/details/app-service/"
  default     = "F1"
}

variable "sku_capactiy" {
  description = "Describes plan's instance count"
  default     = 1
}

variable "collation" {
  description = "The database collation for governing the proper use of characters"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}


variable "edition" {
  description = "The type of database to create; allowed values: 'Basic', 'Standard', and 'Premium'"
  default     = "Basic"
}

variable "max_size_bytes" {
  description = "The maximum size, in bytes, for the database"
  default     = "1073741824"
}

variable "requested_service_objective_name" {
  description = "Describes the performance level for Edition; allowed values: 'Basic', 'S0', 'S1', 'S2', 'P1', 'P2', 'P3'"
  default     = "Basic"
}

variable "cache_sku_name" {
  description = "The pricing tier of the new Azure Redis Cache; allowed values: 'Basic', 'Standard'"
  default     = "Basic"
}

variable "cache_sku_family" {
  description = "The SKU family to use. Valid values are 'C' and 'P', where 'C' = Basic/Standard, 'P' = Premium."
  default     = "C"
}

variable "cache_sku_capacity" {
  description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4."
  default     = 0
}

variable "admin_username" {
  description = "Administrator username of the SQL Server"
  default     = "vmadmin"
}

variable "admin_password" {
  description = "The password of the admin user of the SQL Server"
}
