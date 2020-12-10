# aks-deployment-icap

Deployment for I-CAP Azure resources and AKS Deployment using Terraform

## Terraform Deployment

Clone the following repo from Github

[AKS Deployment ICAP](https://github.com/filetrust/aks-deployment-icap)

You will then need to run the following to initiate the submodules that contain the helm charts.

```
git submodule init
git submodule update
```

Once you've cloned down the repo you will need to run the following.

### Add Terraform Backend key to environment

Follow the below commands to get the backend key for Terraform from the Azure Keyvault
az aks get-credentials --resource-group gw-icap-aks-deploy --name gw-icap-ak
Verify you have access to the backend vault 

```
az keyvault secret show --name terraform-backend-key --vault-name gw-tfstate-Vault --query value -o tsv
```

Next export the environment variable "ARM_ACCESS_KEY" to be able to initialise terraform

```
export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name gw-tfstate-Vault --query value -o tsv)

# now check to see if you can access it through variable

echo $ARM_ACCESS_KEY
```

### Setup and initialise Terraform

Next you'll need to use the following:

```
terraform init
```

Next run terraform validate/refresh to check for changes within the state, and also to make sure there aren't any issues.

```
terraform validate
Success! The configuration is valid.

terraform refresh
```

Now you're ready to run apply and it should give you the following output

```
terraform apply

Plan: 1 to add, 2 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

Once this completes you should see all the infrastructure for the AKS deployed and working.

### Deploy services

Next we will deploy the services using either Helm or Argocd. Both of the Readme's for each can be found below:

[ArgoCD Readme](/argocd/README.md)

***All commands need to be run from the root directory for the paths to be correct***

### Attaching ACRs to cluster

The blow command can be run multiple times to attach ACRs to the working cluster. This is mainly for development purposes as there are various pipelines setup with images being sent to multiple different clusters. In theory as the final product/project is nearing the end we should have a single source of truth for all images.

```bash
az aks update -n myAKSCluster -g myResourceGroup --attach-acr acr1
az aks update -n myAKSCluster -g myResourceGroup --attach-acr acr2
```
