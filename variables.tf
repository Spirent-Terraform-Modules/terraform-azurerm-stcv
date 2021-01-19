#VARIABLES

variable "ingress_cidr_blocks" {
  description = "Ingress CIDR block for instances"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vm_count" {
  type        = string
  description = "Number of STCv VM instances to create."
  default     = "2"
}

variable "vm_size" {
  type        = string
  description = "Specifies the size of the STCv VM instance."
  default     = "Standard_DS3_v2"
}

variable "vm_hostname" {
  type        = string
  description = "Specifies the name of STCv VM instance"
  default     = "STCv-VM"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name in Azure"
  default     = "default"
}

variable "resource_group_location" {
  type        = string
  description = "Resource group location in Azure"
  default     = "West US 2"
}

variable "vnet" {
  type        = string
  description = "User provided vnet"
  default     = "STCv"
}

variable "mgmt_subnet" {
  type        = string
  description = "User provided management subnet"
  default     = "stcv-mgmt"
}

variable "test_subnet" {
  type        = string
  description = "User provided test subnet"
  default     = "stcv-test"
}

variable "enable_accelerated_networking_flag" {
  description = "enable accelerated networking flag"
  type        = string
  default     = "true"
}

variable "os_disk_name" {
  description = "Name of the os disk"
  type        = string
  default     = "stcv-osdisk"
}

variable "admin_username" {
  description = "Administrator user name"
  type        = string
  default     = "azureuser"
}

variable "public_key" {
  description = "Contents of public key."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "marketplace_publishername" {
  type        = string
  description = "Name of the publisher of the image"
  default     = "spirentcommunications1594084187199"
}

variable "marketplace_offer" {
  type        = string
  description = "The name of the offer"
  default     = "testcenter_virtual"
}

variable "marketplace_sku" {
  type        = string
  description = "Image sku to apply "
  default     = "testcentervirtual"
}

variable "marketplace_version" {
  type        = string
  description = "Version of the STCv image to apply"
  default     = "5.15.0106"
}