# Terraform (Single-Instance Bootstrap)

Provision the FoxIDs single-instance environment with Terraform. Terraform installs the foundational components (namespaces, secrets, Argo CD) and then hands control to Argo CD for the application manifests under `single-instance/app`.

## Install Terraform

Follow the official instructions: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

Download binaries (Windows example): https://developer.hashicorp.com/terraform/install

Add Terraform to your `PATH`, e.g. `C:\terraform`.

## Access to the Kubernetes Cluster

Ensure you have cluster-admin credentials. Place your kubeconfig at:

```
.kube\kubeconfig.yml
```

or point the `KUBECONFIG` environment variable to the file before running Terraform.

## Required Variables (`terraform.tfvars`)

Populate `terraform.tfvars` with environment-specific secrets.

```
# Argo CD admin user password (plaintext, Terraform will hash it)
argocd-admin-password         = "admin"

# Git repository that Argo CD should track
git-repo-url                  = "https://xxx.xxx/xxx.git"
# Optional credentials for private repos
git-repo-username             = "xxx@xxx.xxx"
git-repo-password             = "xxx"

# MongoDB credentials (single instance)
mongodb-root-password         = "my-root-password"
# FoxIDs database user password
mongodb-foxids-password       = "my-foxids-db-password"

# OpenSearch admin password and dashboard connector password
opensearch-admin-password             = "my-admin-password"

# Optional SMTP credentials
smtp-username                 = "xxx"
smtp-password                 = "xxx"

# Optional SMS secret
sms-secret                    = "xxx"
```

## Bootstrap with Terraform

Open PowerShell and change directory:

```
cd C:\my-path\FoxIDs.Kubernetes-CD\single-instance\terraform_setup
```

Add Terraform to the current session PATH if needed:

```
$Env:PATH += ';C:\terraform'
```

Initialise the working directory:

```
terraform init
```

Review the plan (optional):

```
terraform plan
```

Apply the configuration (this installs Argo CD and seeds the required secrets):

```
terraform apply -auto-approve
```

When the apply completes, Argo CD will begin reconciling the manifests under `single-instance/app`, deploying MongoDB, OpenSearch, FoxIDs, and related ingress resources as single-instance workloads.

## Cleanup

To tear down every resource created by this module:

```
terraform destroy
```



