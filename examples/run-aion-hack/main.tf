## Example : This Terraform module deploys Spirent TestCenter Virtual Machines from an Azure Marketplace image.
# The example requires the user to provide an already existing virtual network , management subnet, test subnet names.

provider "azurerm" {
  version                    = ">=2.37.0"
  skip_provider_registration = "true"
  features {}
}

data "azurerm_subnet" "mgmt_plane" {
  name = "default"
  virtual_network_name = "rmStcv-net"
  resource_group_name  = "rmVMs"
}

data "azurerm_subnet" "test_plane" {
  name = "testNet"
  virtual_network_name = "rmStcv-net"
  resource_group_name  = "rmVMs"
}

module "stcv" {
  source                    = "../.."
  
  marketplace_version       = "5.15.0106"
  user_data_file            = "../../cloud-init.yaml"
  
  instance_count            = 1
  instance_size             = "Standard_F2s"
  resource_group_name       = "rmVMs"
  resource_group_location   = "East US"
  virtual_network           = "STCv"
  mgmt_plane_subnet_id      = data.azurerm_subnet.mgmt_plane.id
  test_plane_subnet_id      = data.azurerm_subnet.test_plane.id
  public_key                = "~/.ssh/stcv_dev_key.pub"
  private_key_file          = "~/.ssh/stcv_dev_key.pem"

  # Warning: Using all address cidr block to simplify the example. You should restrict addresses to your public network.
  ingress_cidr_blocks       = ["0.0.0.0/0"]
}

output "instance_public_ips" {
  value = module.stcv.*.instance_public_ips
}
