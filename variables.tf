#VARIABLES

variable "ingress_cidr_blocks" {
  description = "List of management interface ingress IPv4/IPv6 CIDR ranges."
  type        = list(string)
}

variable "instance_name" {
  type        = string
  description = "Name assigned to the instance.  An instance number will be appended to the name"
  default     = "stcv"
}

variable "instance_count" {
  type        = string
  description = "Number of STCv instances to create.."
}

variable "instance_size" {
  type        = string
  description = "Specifies the size of the STCv VM instance."
  default     = "Standard_DS3_v2"
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

variable "virtual_network" {
  type        = string
  description = "User provided virtual network"
}

variable "mgmt_plane_subnet" {
  type        = string
  description = "Management public Azure subnet name"
}

variable "test_plane_subnet" {
  type        = string
  description = "Test or data plane Azure subnet name"
}

variable "enable_accelerated_networking" {
  description = "Flag to enable or disable accelerated networking on network interface"
  type        = string
  default     = "true"
}

variable "admin_username" {
  description = "Administrator user name"
  type        = string
  default     = "azureuser"
}

variable "public_key" {
  description = "File path to public key."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "marketplace_version" {
  type        = string
  description = "The Spirent TestCenter Virtual image version example 5.15.0106. When not specified, the latest marketplace image will be used. "
}

variable "user_data_file" {
  description = "File path name containing AWS user data for the instance.  Spirent TestCenter Virtual cloud-init configuration parameters are supported."
  type        = string
}