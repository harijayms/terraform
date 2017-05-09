output "hostname" {
  value = "${azurerm_redis_cache.redis.hostname}"
}

output "db_fqdn" {
  value = "${azurerm_sql_database.db.fully_qualified_domain_name}"
}

output "ssl_port" {
  value = "${azurerm_redis_cache.redis.ssl_port}"
}
