# Deploy FoxIDs (Multi-Node Setup)

Deploy FoxIDs as a scalable, multi-node installation.

- **FoxIDs site** (multi-node)
- **FoxIDs Control site** (multi-node)
- **MongoDB** (multi-node)
- **OpenSearch** (multi-node)

Deployment manifests are located in the [app](app) folder.

The deployment is bootstrapped using either `kubectl` or `Terraform`, followed by GitOps deployment with Argo CD.

## Prerequisites

1. **Clone this repository.**
2. **Update domain references:** Search for `test-multi-nodes.foxids.com` and replace it with your domain.
3. **Update email addresses:** Search for `xxx@my-domain.com` and replace with your appropriate email addresses.
4. **Configure DNS:** Set up DNS records for your domain after obtaining the IP address of your Kubernetes cluster's Ingress controller. Configure DNS as early as possible, since Let's Encrypt certificate issuance uses DNS validation.

## Accessing the Kubernetes Cluster

Configure access to your Kubernetes cluster:

- Place your cluster's `kubeconfig.yml` file in either:
  - `kubectl_setup\kube\kubeconfig.yml` (for kubectl bootstrap)
  - `terraform_setup\kube\kubeconfig.yml` (for Terraform bootstrap)

## Bootstrapping Deployment

Choose a bootstrap method:

- For **kubectl**, continue in the [kubectl_setup](kubectl_setup) folder.
- For **Terraform**, continue in the [terraform_setup](terraform_setup) folder.

> It takes some time from bootstrap deployment is done until Argo CD is ready. You can follow the status via the [Argo CD Dashboard on localhost](app/readme.md#argo_cd_dashboard_on_localhost).

For further details about what is installed, please see the [app](app) folder.
