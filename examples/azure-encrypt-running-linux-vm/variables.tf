variable "resource_group" {
  description = "Resource group name."
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "southcentralus"
}

variable "hostname" {
  description = "Used to form various names including the key vault, vm, and storage. Must be unique."
}

variable "keyvault_tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get using 'az account show'."
}

variable "keyvault_object_id" {
  description = "The object ID of a service principal in the Azure Active Directory tenant for the key vault. Get using 'az ad sp show'."
}

variable "keys_permissions" {
  description = "Permissions to keys in the vault. Valid values are: all, create, import, update, get, list, delete, backup, restore, encrypt, decrypt, wrapkey, unwrapkey, sign, and verify."
  default     = "all"
}

variable "secrets_permissions" {
  description = "Permissions to secrets in the vault. Valid values are: all, get, set, list, and delete."
  default     = "all"
}

variable "vault_sku" {
  description = "SKU for the vault. Valid values are: standard, premium."
  default     = "standard"
}

variable "os_type" {
  description = "Specifies the operating system Type, valid values are windows, linux."
  default     = "linux"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/24"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.0.0/24"
}

variable "storage_account_type" {
  description = "Defines the type of storage account to be created. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS. Changing this is sometimes valid - see the Azure documentation for more information on which types of accounts can be converted into other types."
  default     = "Standard_LRS"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine. This must be the same as the vm image from which you are copying."
  default     = "Standard_A0"
}

variable "image_publisher" {
  description = "name of the publisher of the image (az vm image list)"
  default     = "Canonical"
}

variable "image_offer" {
  description = "the name of the offer (az vm image list)"
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "image sku to apply (az vm image list)"
  default     = "16.04-LTS"
}

variable "image_version" {
  description = "version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "admin_username" {
  description = "administrator user name for the vm"
  default     = "vmadmin"
}

variable "admin_password" {
  description = "administrator password for the vm (recommended to disable password auth)"
}

variable "aad_client_id" {
  description = "Client ID of AAD app which has permissions to KeyVault"
}

variable "aad_client_secret" {
  description = "Client Secret of AAD app which has permissions to KeyVault"
}

variable "disk_format_query" {
  description = "The query string used to identify the disks to format and encrypt. This parameter only works when you set the EncryptionOperation as EnableEncryptionFormat. For example, passing [{\"dev_path\":\"/dev/md0\",\"name\":\"encryptedraid\",\"file_system\":\"ext4\"}] will format /dev/md0, encrypt it and mount it at /mnt/dataraid. This parameter should only be used for RAID devices. The specified device must not have any existing filesystem on it."
  default = ""
}

variable "encryption_operation" {
  description = "EnableEncryption would encrypt the disks in place and EnableEncryptionFormat would format the disks directly"
  default     = "EnableEncryption"
}

variable "volume_type" {
  description = "Defines which drives should be encrypted. OS encryption is supported on RHEL 7.2, CentOS 7.2 & Ubuntu 16.04. Allowed values: OS, Data, All"
  default     = "Data"
}

variable "key_encryption_key_url" {
  description = "URL of the KeyEncryptionKey used to encrypt the volume encryption key"
}

variable "vault_name" {
  description = "name of the vault"
}

# variable "passphrase" {
#   description = "The passphrase for the disks"
# }


variable "sequenceVersion" {
  description = "sequence version of the bitlocker operation. Increment this everytime an operation is performed on the same VM"
  default     = 1
}


# variable "useKek" {
#   description = "Select kek if the secret should be encrypted with a key encryption key. Allowed values: kek, nokek"
#   default = "nokek"
# }


# variable "_artifactsLocation" {
#   description = "The base URI where artifacts required by this template are located. When the template is deployed using the accompanying scripts, a private location in the subscription will be used and this value will be automatically generated."
#   default = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master"
# }


# variable "_artifactsLocationSasToken" {
#   description = "The sasToken required to access _artifactsLocation.  When the template is deployed using the accompanying scripts, a sasToken will be automatically generated."
# }
