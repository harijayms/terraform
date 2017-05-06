# Create a Web App plus Redis Cache plus SQL Database using a template

This template creates a Web App, Redis Cache, and SQL Database in the same resource group, and creates two connection strings in the Web App for the SQL Database and Redis Cache.

For information about using this template, see [Create a Web App plus Redis Cache using a template](https://azure.microsoft.com/en-us/documentation/articles/cache-web-app-arm-with-redis-cache-provision/) and [Provision a web app with a SQL Database](https://azure.microsoft.com/en-us/documentation/articles/app-service-web-arm-with-sql-database-provision/).

## main.tf
The `main.tf` file contains the actual resources that will be deployed. It also contains the Azure Resource Group definition and any defined variables. 

## outputs.tf
This data is outputted when `terraform apply` is called, and can be queried using the `terraform output` command.

## provider.tf
Azure requires that an application is added to Azure Active Directory to generate the `client_id`, `client_secret`, and `tenant_id` needed by Terraform (`subscription_id` can be recovered from your Azure account details). Please go [here](https://www.terraform.io/docs/providers/azurerm/) for full instructions on how to create this to populate your `provider.tf` file.

## terraform.tfvars
If a `terraform.tfvars` file is present in the current directory, Terraform automatically loads it to populate variables. We don't recommend saving usernames and password to version control, but you can create a local secret variables file and use `-var-file` to load it.

If you are committing this template to source control, please insure that you add this file to your .gitignore file.

## variables.tf
The `variables.tf` file contains all of the input parameters that the user can specify when deploying this Terraform template.
