#!/bin/bash

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

# install terraform
curl "https://releases.hashicorp.com/terraform/"+=$TERRAFORM_VERSION+="/terraform_"+=$TERRAFORM_VERSION+="_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_linux_amd64.zip
echo $TERRAFORM_SHA256SUM+="  terraform_"+=$TERRAFORM_VERSION+="_linux_amd64.zip" > "terraform_"+=$TERRAFORM_VERSION+="_SHA256SUMS"
sha256sum -cs "terraform_"+=$TERRAFORM_VERSION+="_SHA256SUMS"
unzip "terraform_"+=$TERRAFORM_VERSION+="_linux_amd64.zip" -d /bin
rm -f "terraform_"+=$TERRAFORM_VERSION+="_linux_amd64.zip"
