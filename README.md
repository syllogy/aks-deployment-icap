# aks-deployment-icap

Deployment for I-CAP Azure resources and AKS Deployment using Terraform

# Standing up Adaptation Service

After you have deployed the AKS Cluster to Azure you will then need to follow the steps below to stand up the Adaptation service.

## Deploying Adaptation Cluster - using helm

Deploying to AKS

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
kubectl exec rabbitmq-controller-747n4 -- /bin/bash -c "rabbitmq-plugins enable rabbitmq_management"
```

Setup of port forwarding from a local port (e.g. 8080) to the RabbitMQ Management Port
```
kubectl port-forward -n icap-adaptation rabbitmq-controller-747n4 8080:15672
```
The management console now accessible through the browser
```
http://localhost:8080/
```

### Attaching ACRs to cluster

The blow command can be run multiple times to attach ACRs to the working cluster. This is mainly for development purposes as there are various pipelines setup with images being sent to multiple different clusters. In theory as the final product/project is nearing the end we should have a single source of truth for all images.

```bash
az aks update -n myAKSCluster -g myResourceGroup --attach-acr acr1
az aks update -n myAKSCluster -g myResourceGroup --attach-acr acr2
```
