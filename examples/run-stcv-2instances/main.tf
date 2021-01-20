## Example:This example deploys a Spirent TestCenter Virtual Machine from an Azure Marketplace image.

data "azurerm_subnet" "mgmt_plane" {
  name                 = "stcv-mgmt"
  virtual_network_name = "STCv"
  resource_group_name  = "default"
}

data "azurerm_subnet" "test_plane" {
  name                 = "stcv-test"
  virtual_network_name = "STCv"
  resource_group_name  = "default"
}

module "stcv" {
  source                    = "../.."
  
  instance_count            = 2
  resource_group_location   = "West US 2"
  virtual_network           = "STCv"
  mgmt_plane_subnet         = data.azurerm_subnet.mgmt_plane.id
  test_plane_subnet         = data.azurerm_subnet.test_plane.id
  ingress_cidr_blocks       = ["0.0.0.0/0"]
  user_data_file            = "../../cloud-init.yaml"
  marketplace_version       = "5.15.0106"
}

output "instance_public_ips" {
  value = module.stcv.*.instance_public_ips
}