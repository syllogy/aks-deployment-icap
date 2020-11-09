DEVELOPMENT BRANCH

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

## Standing up the Adaptation Service

After you have deployed the AKS Cluster to Azure you will then need to follow the steps below to stand up the Adaptation service.

### Deploying Adaptation Cluster - using helm

Deploying to AKS

In order to get the credentials for the AKS cluster you must run the command below:

```
az aks get-credentials --name gw-icap-aks --resource-group gw-icap-aks-deploy
```

*all commands below should be run from the root directory of the repo "aks-deployment-icap"*

Create the Kubernetes namespace
```
kubectl create ns icap-adaptation
```

Create container registry secret - this requires a service account created within Dockerhub
```
kubectl create -n icap-adaptation secret docker-registry regcred	\ 
	--docker-server=https://index.docker.io/v1/ 	\
	--docker-username=<username>	\
	--docker-password="<password>"	\ # Please ensure you add quotes to password
	--docker-email=<email address>
```

Install the cluster components
```
helm install ./helm_charts/icap-infrastructure/adaptation --namespace icap-adaptation --generate-name
```

The cluster's services should now be deployed (Please note the adaptation service can restart several times before it is "running")
```
> kubectl get pods -n icap-adaptation
NAME                                 READY   STATUS    RESTARTS   AGE
adaptation-service-64cc49f99-kwfp6   1/1     Running   0          3m22s
mvp-icap-service-b7ddccb9-gf4z6      1/1     Running   0          3m22s
rabbitmq-controller-747n4            1/1     Running   0          3m22s
```

If required, the following steps provide access to the RabbitMQ Management Console

Run the below command to enable the Management Plugin, this step takes a couple of minutes
```
kubectl exec -it rabbitmq-controller-747n4 -- /bin/bash -c "rabbitmq-plugins enable rabbitmq_management"
```

Setup of port forwarding from a local port (e.g. 8080) to the RabbitMQ Management Port
```
kubectl port-forward -n icap-adaptation rabbitmq-controller-747n4 8080:15672
```
The management console now accessible through the browser
```
http://localhost:8080/
```
### Standing up Management UI

All of these commands are run int he root folder. Firstly create the namespace

```
kubectl create ns management-ui
```

Next use Helm to deploy the chart

```
helm install ./pod-creations/icap-management-ui/kube --namespace management-ui --generate-name
```

Services should start on their own and the management UI will be available from the public IP that is attached to the load balancer.

To see this use the following command

```
❯ kubectl get service -n management-ui
NAME                             TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
icap-management-portal-service   LoadBalancer   xxx.xxx.xxx.xxx   xxx.xxx.xxx.xxx   80:32231/TCP   24h
```

### Standing up Transaction-Event-API

All of these commands are run int he root folder. Firstly create the namespace

```
kubectl create ns transaction-event-api
```

Next use Helm to deploy the chart

```
helm install ./pod-creations/transaction-event-api/TransactionEventApi/charts --namespace management-ui --generate-name
```

### Attaching ACRs to cluster

The blow command can be run multiple times to attach ACRs to the working cluster. This is mainly for development purposes as there are various pipelines setup with images being sent to multiple different clusters. In theory as the final product/project is nearing the end we should have a single source of truth for all images.

```bash
az aks update -n myAKSCluster -g myResourceGroup --attach-acr acr1
az aks update -n myAKSCluster -g myResourceGroup --attach-acr acr2
```
