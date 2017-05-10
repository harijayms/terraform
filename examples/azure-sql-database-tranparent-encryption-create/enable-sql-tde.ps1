password=ConvertTo-SecureString $ARM_CLIENT_SECRET -AsPlainText -Force
cred=New-Object System.Management.Automation.PSCredential($ARM_CLIENT_ID, password)

Add-AzureRmAccount -Credential cred -TenantId $ARM_TENANT_ID -ServicePrincipal
Set-AzureRMSqlDatabaseTransparentDataEncryption -ServerName ${sql_server_name} -ResourceGroupName ${resource_group_name} -DatabaseName ${sql_database_name} -State Enabled
Get-AzureRMSqlDatabaseTransparentDataEncryption -ServerName ${sql_server_name} -ResourceGroupName ${resource_group_name} -DatabaseName ${sql_database_name}
Get-AzureRMSqlDatabaseTransparentDataEncryptionActivity -ServerName ${sql_server_name} -ResourceGroupName ${resource_group_name} -DatabaseName ${sql_database_name}