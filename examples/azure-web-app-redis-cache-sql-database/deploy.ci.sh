#!/bin/bash

set -o errexit -o nounset

docker run --rm -it \
  -e ARM_CLIENT_ID \
  -e ARM_CLIENT_SECRET \
  -e ARM_SUBSCRIPTION_ID \
  -e ARM_TENANT_ID \
  -v $(pwd):/data \
  --entrypoint "/bin/sh" \
  hashicorp/terraform:light \
  -c "cd /data; \
      /bin/terraform get; \
      /bin/terraform validate; \
      /bin/terraform plan -out=out.tfplan -var db_name=$KEY -var resource_group=$KEY -var admin_password=$PASSWORD; \
      /bin/terraform apply out.tfplan"

# cleanup deployed azure resources via azure-cli
docker run --rm -it \
  azuresdk/azure-cli-python \
  sh -c "az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID > /dev/null; \
         az sql db show -g $KEY -n $KEY-db -s $KEY-sqlsvr; \
         az sql server show -g $KEY -n $KEY-sqlsvr; \
         az webapp show -n $KEY -g $KEY; \
         az redis show -n $KEY -g $KEY;

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
  -c "/bin/terraform destroy -force -var db_name=$KEY -var resource_group=$KEY -var admin_password=$PASSWORD;"
