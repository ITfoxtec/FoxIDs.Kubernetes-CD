# Deploy FoxIDs (Single-Instance Setup)

Spin up FoxIDs in a compact single-instance Kubernetes footprint that prioritises simplicity over high availability.

- FoxIDs site (single replica)
- FoxIDs Control site (single replica)
- MongoDB (single-pod StatefulSet)
- OpenSearch (single-pod StatefulSet)
- OpenSearch Dashboards (optional, single replica)

Minimum recommended cluster capacity: one worker node with 4 vCPUs, 8 GB RAM, and 80 GiB SSD storage.

Manifests live in the [app](app) directory and are continuously reconciled by Argo CD after the initial bootstrap (via kubectl or Terraform).

## Before You Start

1. Clone this repository.
2. Replace every occurrence of the placeholder base domain `test-single-instance.foxids.com` with your real domain (for example `my-company.com`).
   - FoxIDs: `id.test-single-instance.foxids.com`
   - FoxIDs Control: `control.test-single-instance.foxids.com`
   - Argo CD (optional): `argocd.test-single-instance.foxids.com`
   - OpenSearch Dashboards (optional): `opensearch.test-single-instance.foxids.com`
3. Update the placeholder contact emails (`xxx@my-domain.com`).
4. Decide whether you want to bootstrap with kubectl or Terraform (both options are provided).

## Accessing the Kubernetes Cluster

Supply a kubeconfig before running any bootstrap commands.

- For kubectl bootstrap: place it at `kubectl_setup/.kube/kubeconfig.yml`.
- For Terraform bootstrap: place it at `terraform_setup/.kube/kubeconfig.yml`.

## Bootstrap Deployment

Pick one bootstrap path and follow the README in that folder:

- [`kubectl_setup`](kubectl_setup/README.md) - apply the manifests directly with kubectl.
- [`terraform_setup`](terraform_setup/README.md) - let Terraform provision Argo CD, namespaces, and secrets, then hand off to GitOps.

Once Argo CD is running you can monitor progress by port-forwarding the Argo CD server and signing in with the admin password defined in `terraform.tfvars` (or the secret you create during kubectl bootstrap).


