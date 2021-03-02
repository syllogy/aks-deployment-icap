# How to use the Terraform Deployment

## Overview

This code is broken down into 4 separate deployments, in order to keep each cluster isolated from each other and to enable us to down clusters without interfering with others.

The code is broken down into various modules for each of the different infrastructure items. The modules are customisable within the limits of the Azurerm provider (documentation [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)) - any changes to infrastructure code should be either added in as a PR, fully tested and finally merged into main.

A top level view of the deployment is below:

```
.
├── README.md
├── backend.tfvars
├── certs
│   ├── file-drop-cert
│   │   ├── certificate.crt
│   │   └── tls.key
│   ├── icap-cert
│   │   ├── certificate.crt
│   │   └── tls.key
│   └── mgmt-cert
│       ├── certificate.crt
│       └── tls.key
├── main.tf
├── modules
│   ├── clusters
│   │   ├── file-drop-cluster
│   │   │   ├── README.md
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── icap-cluster
│   │       ├── README.md
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── keyvault
│   │   ├── README.md
│   │   ├── main.tf
│   │   └── variables.tf
│   └── storage-account
│       ├── README.md
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── output.tf
├── provider.tf
├── terraform.tfvars
└── variables.tf

10 directories, 28 files
```
### Backend configuration

Terraform uses a state file to store the current infrastructure that has been deployed. This state file can be stored locally or using a configured backend (in our case its blob storage within Azure). When configured properly you should not need to worry about the state file as this will be automatically updated by Terraform on each successful deployment. 

We are using a ```tfvars``` file to input the backend configuration for the state file, please see below:

```
resource_group_name  = "gw-icap-tfstate"
storage_account_name = "tfstate263"
container_name       = "gw-icap-tfstate"
key                  = "01uks.terraform.tfstate"
```

In order to store the state file you need to make sure you have created a storage account within azure and with container blob storage. The only unique part of the file above is the ```key``` - as this is used to differentiate between each deployment.

### Customising the deployment

In order to customise the deployment so you can identify it for you own usage, you can use the ```terraform.tfvars``` file. This file has variables that will give values you input to make sure it's unique and is deployed in the correct regions etc.

Typically what the ```tfvars``` looks like:

```
azure_region           = "uksouth"
suffix                 = "dev"

domain                 = "cloudapp.azure.com"

icap_port              = 1344
icap_tlsport           = 1345
```

The main variable that will help you identify a cluster is the ```suffix```. This will get appended into a resource name, so if you set it to ```xyz``` you would then see a cluster with the same once it's deployed. Something to bear in mind is you are limited on characters, as there is already a naming convection set within the ```main.tf``` file within the root of each deployment. Typically you would want to use between 1 and 5 characters in order for it to not exceed the character limit.

Other than this you should not need to touch any of the actual terraform code to deploy a working cluster.

### File Structure