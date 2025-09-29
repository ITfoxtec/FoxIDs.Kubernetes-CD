# Terraform

Bootstrap FoxIDs deployment in Kubernetes with Terraform.

## Install Terraform

About installing Terraform  
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

Download  
https://developer.hashicorp.com/terraform/install

E.g., install Terraform in `C:\terraform;`

# Access to Kubernetes cluster

Configure access to you Kubernetes cluster.

Place your clusters `kubeconfig.yml` file in:
```
.kube\kubeconfig.yml
```

# Environment variables

Create a `terraform.tfvars` file with environment variables.
```
# Argo CD admin users password
argocd-admin-password          = "admin"

# Add your git repository, this git repository is https://github.com/ITfoxtec/FoxIDs.Kubernetes-CD.git
git-repo-url                   = "https://xxx.xxx/xxx.git"

# Optionally, add access to private Git repository
git-repo-username              = "xxx@xxx.xxx"
git-repo-password              = "xxx"

# MongoDB Root user password
mongodb-root-password          = "my-root-password"
# FoxIDs DB user password
mongodb-foxids-password        = "my-foxids-db-password"

# OpenSearch admin user password
opensearch-password            = "my-admin-password"
# Password used by Dashboards connecting to OpenSearch
opensearch-dashdoard-connect-password = "my-dashdoard-connect-password"
# Internal OpenSearch password for the Dashboard

# Optionally, SMTP username and password
smtp-username                  = "xxx"
smtp-password                  = "xxx"

# Optionally, SMS secret for e.g. https://gatewayapi.eu
sms-secret                     = "xxx"

```

## Bootstrap FoxIDs deployment

Open PowerShell and navigate to this folder e.g.
```
cd C:\my-path\FoxIDs.Kubernetes-CD\multi_nodes\terraform_setup
```

In PowerShell add a path to terraform.
```
$Env:PATH += ';C:\terraform'
```

Initialise Terraform
```
terraform init
```

Plan (optional)
```
terraform plan
```

Apply to deploy
```
terraform apply -auto-approve
```

Destroy - OPTIONAL cleanup
```
terraform destroy
```

