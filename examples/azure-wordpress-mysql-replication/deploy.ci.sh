#!/bin/bash

set -o errexit -o nounset

docker run --rm -it \
  -e ARM_CLIENT_ID \
  -e ARM_CLIENT_SECRET \
  -e ARM_SUBSCRIPTION_ID \
  -e ARM_TENANT_ID \
  -v $(pwd):/data \
  --workdir=/data \
  --entrypoint "/bin/sh" \
  hashicorp/terraform:light \
  -c "/bin/terraform get; \
      /bin/terraform validate; \
      /bin/terraform plan -out=out.tfplan \
        -var resource_group=$KEY \
        -var unique_prefix=$KEY \
        -var site_name=$KEY \
        -var dns_name=$KEY \
        -var hosting_plan_name=$KEY \
        -var mysql_root_password=$PASSWORD \
        -var mysql_replication_password=$PASSWORD \
        -var mysql_probe_password=$PASSWORD \
        -var vm_admin_username=$KEY \
        -var vm_admin_password=$PASSWORD; \
      /bin/terraform apply out.tfplan"

# cleanup deployed azure resources via azure-cli
docker run --rm -it \
  azuresdk/azure-cli-python \
  sh -c "az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID > /dev/null; \
         az vm list -g $KEY; \
         az webapp show -n $KEY -g $KEY"

# cleanup deployed azure resources via terraform
docker run --rm -it \
  -e ARM_CLIENT_ID \
  -e ARM_CLIENT_SECRET \
  -e ARM_SUBSCRIPTION_ID \
  -e ARM_TENANT_ID \
  -v $(pwd):/data \
  --workdir=/data \
  --entrypoint "/bin/sh" \
  hashicorp/terraform:light \
  -c "/bin/terraform destroy -force \
    -var resource_group=$KEY \
    -var unique_prefix=$KEY \
    -var site_name=$KEY \
    -var dns_name=$KEY \
    -var hosting_plan_name=$KEY \
    -var mysql_root_password=$PASSWORD \
    -var mysql_replication_password=$PASSWORD \
    -var mysql_probe_password=$PASSWORD \
    -var vm_admin_username=$KEY \
    -var vm_admin_password=$PASSWORD;"