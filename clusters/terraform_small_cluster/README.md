# Terraform

Install Terraform  
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

Download  
https://developer.hashicorp.com/terraform/install

Place terraform.exe in folder `C:\terraform`  

Open PowerShell and navigate to this folder e.g.
```
cd C:\src\GitHub\FoxIDs.Kubernetes-CD\clusters\terraform_small_cluster
```

Add path to terraform
```
$Env:PATH += 'C:\terraform;'
```

## Create K8s cluster in OVHCloud
https://registry.terraform.io/providers/ovh/ovh/latest/docs/resources/cloud_project_kube

### Get credentials 
Open "https://api.ovh.com/createToken/?GET=/*&POST=/*&PUT=/*&DELETE=/*"

### Use Terraform to create K8s cluster with Argo CD and retrieve kubeconfig

Initialise Terraform
```
terraform init
```

Plan
```
terraform plan
```

Apply
```
terraform apply
```

Export kubeconfig
```
New-Item -Name ".kube" -ItemType Directory
terraform output -raw kubeconfig_file > .kube/kubeconfig.yml
```

Destroy (cleanup) - OPTIONAL
```
terraform destroy 
```

# Argo CD
https://argo-cd.readthedocs.io/en/stable/getting_started/

## Get admin secret
Start Linux prompt
```
wsl
```

Path to kubernetes config
```
export KUBECONFIG=.kube/kubeconfig.yml
```

Get admin users password
```
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
```

## Open Argo CD 
https://localhost:3443

```
kubectl port-forward svc/argocd-server -n argocd 3443:443
```

# Kubectl on Windows
Path to kubernetes config
```
$env:KUBECONFIG=".kube\kubeconfig.yml"
```