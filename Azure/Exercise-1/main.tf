###################################################################################################################################
# VARIABLES 
###################################################################################################################################

variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
    default = "eastus"
}

variable "vnet_cidr_range" {
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_prefixes" {
    type = list(string)
    default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnet_names" {
    type = list(string)
    default = ["web", "database"]
}

#################################################################################################################################
# PRIVIDERS
#################################################################################################################################

provider "azurerm" {

}

# this will be automatically filled in when using azure CLI

#################################################################################################################################
# RESOURCES
#################################################################################################################################
# We are using a module to deploy aour virtual network

module "vnet-main" {
    source = "Azure/vnet/azurerm" #This source is on Terraform public registry. See here: https://registry.terraform.io/modules/Azure/vnet/azurerm/1.2.0
    resource_group_name = var.resource_group_name
    location = var.location
    vnet_name = var.resource_group_name
    address_space = var.vnet_cidr_range
    subnet_prefixes = var.subnet_prefixes
    subnet_names = var.subnet_names
    nsg_ids = {}

    tags = {
        environment = "dev"
        conscenter ="it"
    }
}