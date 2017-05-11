#!/usr/bin/env sh

set -o errexit -o nounset

TERRAFORM_VERSION=0.9.4
TERRAFORM_SHA256SUM=cc1cffee3b82820b7f049bb290b841762ee920aef3cf4d95382cc7ea01135707

apt update
apt install -y --no-install-recommends git curl openssh-client unzip apt-utils ca-certificates apt-transport-https

# Import the public repository GPG keys for Microsoft
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Register the Microsoft Ubuntu 14.04 repository
curl https://packages.microsoft.com/config/ubuntu/14.04/prod.list | tee /etc/apt/sources.list.d/microsoft.list

# Install powershell from Microsoft Repo
apt-get update
apt-get install -y --no-install-recommends powershell

#Azure RM NetCore Preview Module Install
powershell Install-Module AzureRM.NetCore.Preview -Force
powershell Import-Module AzureRM.NetCore.Preview
if [[ $? -eq 0 ]]
    then
        echo "Successfully installed PowerShell Core with AzureRM NetCore Preview Module."
    else
        echo "PowerShell Core with AzureRM NetCore Preview Module did not install successfully." >&2
fi

# install terraform
curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip

echo ${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_SHA256SUMS

sha256sum -c --quiet terraform_${TERRAFORM_VERSION}_SHA256SUMS

unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
