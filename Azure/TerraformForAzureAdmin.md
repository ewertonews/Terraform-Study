| ARM TEMPLATE               |        TERRAFORM             
|----------------------------|------------------------------
| JSON                       | Hashcorp Config. Language    
| Parameters                 | Variables                    
| Variables                  | Local Variables
| Resources                  | Resources
| Functions                  | Functions
| Nested Templates           | Moddules 
| Explicit dependency        | Automatic dependency
| Refer by ref. or res. id   | Refer by res. or data source

# Providers options for Azure

* Azure - basic azure provider (public cloud)
* Azure Stack -  on promises extension of MS Azure
* Azure Active Directory - relatively new

## Characteristics of a terraform provider?

- Versioned
- Have datasources
    - This is information that you can pull from the provider about your target environment. List or market place images or get an existing Virtual Network that has already been provisioned
- Resources
    - Things that you can create in the target environment. VM, VNET, etc.
- Modules
    - Help you easily deploy common configurations for that provider
- Authentication
    - To interact with that provider

## Authentication options

- Azure CLI
- Managed Service Identity
- Service Principal with client secret
- Service principal with client certificate

## AzureRM Provider Example
```terraform
provider "azurerm" {
    version = "~> 1.0"
    alias = "networking"
    subscription_id = "var.client_id
    client_secret = var.client_secret    
}
```
## Environment Variables
### We can specify some of these values using environment variables

ARM_CLIENT_ID # Sevice principal ID

ARM_CLIENT_SECRET # Service principal secret

ARM_ENVIRONMENT # Azure environement: public, Gov., etc

ARM_SUBSCRIPTION_ID # Azure subscription ID

ARM_TENANT_ID # Azure AD tenant ID for service principal

ARM_USE_MSI # Use Managed Service Identity

### Exercise 1 - create the following scenário:
![bindingsdetails](.\Exercise-1\ScenarioOverview.png "Title")


