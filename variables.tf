#VARIABLES

variable "instance_name" {
  type        = string
  description = "Name assigned to the instance.  An instance number will be appended to the name"
  default     = "stcv"
}

variable "instance_size" {
  type        = string
  description = "Specifies the size of the STCv VM instance"
  default     = "Standard_DS3_v2"
}

variable "resource_group_name" {
  description = "Provide resource group name in Azure"
  type        = string
  default     = "default"
}

variable "resource_group_location" {
  type        = string
  description = "Resource group location in Azure"
  default     = "West US"
}

variable "enable_accelerated_networking" {
  description = " Enable or disable accelerated networking on the network interface"
  type        = string
  default     = "true"
}

variable "admin_username" {
  description = "Administrator user name"
  type        = string
  default     = "azureuser"
}

variable "instance_count" {
  type        = number
  description = "Number of STCv instances to create"
  default     = 2
}

variable "virtual_network" {
  default     = ""
  description = "Provide virtual network name.  If left blank, a new one will be created for you"
  type        = string
}

variable "mgmt_plane_subnet_name" {
  default     = ""
  description = "Provide Management public Azure subnet name.  If left blank, a new one will be created for you"
  type        = string
}

variable "test_plane_subnet_name" {
  default     = ""
  description = "Provide Test or data plane Azure subnet name.  If left blank, a new one will be created for you"
  type        = string
}

variable "mgmt_plane_subnet_id" {
  description = "Management public Azure subnet ID"
  type        = string
}

variable "test_plane_subnet_id" {
  description = "Test or data plane Azure subnet ID"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "List of management interface ingress IPv4/IPv6 CIDR ranges"
  type        = list(string)
}

variable "public_key" {
  description = "File path to public key"
  type        = string
}

variable "marketplace_version" {
  type        = string
  description = "TThe Spirent TestCenter Virtual image version (e.g. 5.15.0106). When not specified, the latest marketplace image will be used"
}

variable "user_data_file" {
  description = "Path to the file containing user data for the instance. See README for Spirent TestCenter Virtual cloud-init configuration parameters that are supported"
  type        = string
}