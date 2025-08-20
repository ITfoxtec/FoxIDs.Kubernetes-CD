# Deploy FoxIDs

Deploy FoxIDs as an installation with multi notes.

- FoxIDs site (multi node)
- FoxIDs Control site (multi node)
- MongoDB (multi node)
- OpenSearch (multi node)

The deployment is found in the [app](app) folder.
   
The deployment is bootstrapped with either `kubectl` or `Terraform` and then the Argo CD do GitOps deployment.

## Before you start

1) Clone this git repository

2) Search `test-multi-nodes.foxids.com` and replace the domain with your domain.

3) Search `xxx@my-domain.com` and replace the email with your appropriated emails.

# Access to Kubernetes cluster

Configure access to you Kubernetes cluster.

Place your clusters `kubeconfig.yml` file in: `.kubectl_setup\kube\kubeconfig.yml` or `.terraform_setup\kube\kubeconfig.yml` depending on which bootstrap method you choose.

## Bootstrap deployment

Bootstrap deployment with either `kubectl` or `Terraform`.

For `kubectl` continue in the [kubectl_setup](kubectl_setup) folder.

For `Terraform` continue in the [terraform_setup](terraform_setup) folder.
