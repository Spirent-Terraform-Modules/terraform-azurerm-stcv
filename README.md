# terraform-azurerm-stcv

## Requirements

| Name | Version |
|------|---------|
| azurerm | 2.37.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | 2.37.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_username | Administrator user name | `string` | `"azureuser"` | no |
| enable\_accelerated\_networking\_flag | Flag to enable or disable accelerated networking on network interface | `string` | `"true"` | no |
| ingress\_cidr\_blocks | Ingress CIDR block for instances | `string` | `"0.0.0.0/0"` | no |
| marketplace\_offer | The name of the offer | `string` | `"testcenter_virtual"` | no |
| marketplace\_publishername | Name of the publisher of the image | `string` | `"spirentcommunications1594084187199"` | no |
| marketplace\_sku | Image sku to apply | `string` | `"testcentervirtual"` | no |
| marketplace\_version | Version of the STCv image to apply | `string` | `"5.15.0106"` | no |
| mgmt\_subnet | User provided management subnet | `string` | `"stcv-mgmt"` | no |
| os\_disk\_name | Name of the os disk | `string` | `"stcv-osdisk"` | no |
| public\_key | Contents of public key. | `string` | `"~/.ssh/id_rsa.pub"` | no |
| resource\_group\_location | Resource group location in Azure | `string` | `"West US 2"` | no |
| resource\_group\_name | Resource group name in Azure | `string` | `"default"` | no |
| test\_subnet | User provided test subnet | `string` | `"stcv-test"` | no |
| vm\_count | Number of STCv VM instances to create. | `string` | `"2"` | no |
| vm\_hostname | Specifies the name of STCv VM instance | `string` | `"STCv-VM"` | no |
| vm\_size | Specifies the size of the STCv VM instance. | `string` | `"Standard_DS3_v2"` | no |
| vnet | User provided vnet | `string` | `"STCv"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | List of IDs of instances |
| vm\_private\_ip | List of private IP addresses assigned to the instances, if applicable |
| vm\_public\_ip | List of public IP addresses assigned to the instances, if applicable |