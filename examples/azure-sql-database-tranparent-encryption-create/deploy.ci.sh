#!/usr/bin/env sh

set -o errexit -o nounset

terraform get
terraform validate
terraform plan -out=out.tfplan -var resource_group=$KEY -var sql_admin=$KEY -var sql_password=$PASSWORD
terraform apply out.tfplan
terraform show

# # check that resources exist via azure cli
# docker run --rm -it \
#   azuresdk/azure-cli-python \
#   sh -c "az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID > /dev/null; \
#          az sql db show -g $KEY -n MySQLDatabase -s $KEY-sqlsvr; \
#          az sql server show -g $KEY -n $KEY-sqlsvr;"
#
# # cleanup deployed azure resources via terraform
# docker run --rm -it \
#   -e ARM_CLIENT_ID \
#   -e ARM_CLIENT_SECRET \
#   -e ARM_SUBSCRIPTION_ID \
#   -e ARM_TENANT_ID \
#   -v $(pwd):/data \
#   --workdir=/data \
#   --entrypoint "/bin/sh" \
#   10thmagnitude/terraform-ps \
#   -c "/bin/terraform destroy -force -var resource_group=$KEY -var sql_admin=$KEY -var sql_password=$PASSWORD;"
