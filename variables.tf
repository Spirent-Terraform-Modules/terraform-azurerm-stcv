#VARIABLES

variable "instance_name" {
  type        = string
  description = "Name assigned to the instance.  An instance number will be appended to the name."
  default     = "stcv"
}

variable "instance_size" {
  type        = string
  description = "Specifies the size of the STCv VM instance."
  default     = "Standard_DS3_v2"
}

variable "instance_count" {
  type        = number
  description = "Number of STCv instances to create."
  default     = 2
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name in Azure."
  default     = "default"
}

variable "resource_group_location" {
  type        = string
  description = "Resource group location in Azure."
  default     = "West US"
}

variable "enable_accelerated_networking" {
  type        = string
  description = "Enable or disable accelerated networking on the network interface."
  default     = "true"
}

variable "admin_username" {
  type        = string
  description = "Administrator user name."
  default     = "azureuser"
}

variable "virtual_network" {
  type        = string
  description = "Azure virtual network name."
  default     = ""
}

variable "mgmt_plane_subnet_id" {
  type        = string
  description = "Management public Azure subnet ID."
  default     = ""
}

variable "test_plane_subnet_id" {
  type        = string
  description = "Test or data plane Azure subnet ID."
  default     = ""
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "List of management interface ingress IPv4/IPv6 CIDR ranges."
}

variable "public_key" {
  type        = string
  description = "File path to public key."
}

variable "marketplace_version" {
  type        = string
  description = "The Spirent TestCenter Virtual image version (e.g. 5.15.0106). When not specified, the latest marketplace image will be used."
}

variable "user_data_file" {
  type        = string
  description = "Path to the file containing user data for the instance. See README for Spirent TestCenter Virtual cloud-init configuration parameters that are supported."
}