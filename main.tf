provider "azurerm" {
  version                      = "2.37.0"
  skip_provider_registration   = "true"
  features {}
}

# Get existing subnet details
data "azurerm_subnet" "mgmt" {
  name                 = var.mgmt_subnet
  virtual_network_name = var.vnet
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "test" {
  name                 = var.test_subnet
  virtual_network_name = var.vnet
  resource_group_name  = var.resource_group_name
}

resource "azurerm_public_ip" "stcv_publicip" {
  count               = var.vm_count
  name                = "publicip-${var.vm_hostname}-${count.index}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "mgmt" {
  name                = "mgmtnsg-${var.vm_hostname}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  # SSH rule
  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ingress_cidr_blocks
    destination_address_prefix = "*"
  }
  # Chassis
  security_rule {
    name                       = "Chassis"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "40004"
    source_address_prefix      = var.ingress_cidr_blocks
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "stcvport"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "51204"
    source_address_prefix      = var.ingress_cidr_blocks
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "test" {
  name                = "testnsg-${var.vm_hostname}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  # all traffic
  security_rule {
    name                       = "all-traffic"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.ingress_cidr_blocks
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "mgmt_nic" {
  count               = var.vm_count
  name                = "mgmtnic-${var.vm_hostname}-${count.index}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "mgmtipconfig-${var.vm_hostname}-${count.index}"
    subnet_id                     = data.azurerm_subnet.mgmt.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.stcv_publicip.*.id, count.index)}"
  }
}

resource "azurerm_network_interface" "test_nic" {
  count                         = var.vm_count
  name                          = "testnic-${var.vm_hostname}-${count.index}"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  enable_accelerated_networking = var.enable_accelerated_networking_flag

  ip_configuration {
    name                          = "testipconfig-${var.vm_hostname}-${count.index}"
    subnet_id                     = data.azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "mgmtnsg_association" {
  count                     = var.vm_count
  network_interface_id      = "${element(azurerm_network_interface.mgmt_nic.*.id, count.index)}"
  network_security_group_id = azurerm_network_security_group.mgmt.id
}

resource "azurerm_network_interface_security_group_association" "testnsg_association" {
  count                     = var.vm_count
  network_interface_id      = "${element(azurerm_network_interface.test_nic.*.id, count.index)}"
  network_security_group_id = azurerm_network_security_group.test.id
}


# Create STCv VMs
resource "azurerm_linux_virtual_machine" "stcv" {
  count                 = var.vm_count
  name                  = "${var.vm_hostname}${count.index}"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = ["${element(azurerm_network_interface.mgmt_nic.*.id, count.index)}", "${element(azurerm_network_interface.test_nic.*.id, count.index)}"]
  size                  = var.vm_size
  admin_username        = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }

  custom_data = base64encode(file("cloud-init.yaml"))

  plan {
    name      = var.marketplace_sku
    publisher = var.marketplace_publishername
    product   = var.marketplace_offer
  }

  os_disk {
    name                 = "${var.vm_hostname}${var.os_disk_name}${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.marketplace_publishername
    offer     = var.marketplace_offer
    sku       = var.marketplace_sku
    version   = var.marketplace_version
  }
}



