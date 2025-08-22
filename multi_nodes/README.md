# Deploy FoxIDs (Multi-Node Setup)

Deploy FoxIDs in a scalable, highly available multi-node topology.

- **FoxIDs site** (multi-node)
- **FoxIDs Control site** (multi-node)
- **MongoDB** (replica set)
- **OpenSearch** (cluster)

Minimum recommended cluster size: 3 worker nodes (servers), each with 4 vCPUs, 16 GB RAM, and 100 GiB SSD.

Deployment manifests are located in the [app](app) folder.

The deployment is bootstrapped using either `kubectl` or `Terraform`, followed by GitOps reconciliation with Argo CD.

## Prerequisites

1. Clone this repository.  
2. Replace all occurrences of the placeholder base domain `test-multi-nodes.foxids.com` with your real domain (e.g. `my-company.com`).  
   Default hostnames (update as needed):
   - FoxIDs: `id.test-multi-nodes.foxids.com`
   - FoxIDs Control: `control.test-multi-nodes.foxids.com`
   - Argo CD (optional): `argocd.test-multi-nodes.foxids.com`
   - OpenSearch Dashboards (optional): `opensearch.test-multi-nodes.foxids.com`
3. Replace placeholder emails `xxx@my-domain.com` with valid addresses.
4. When tested change to use production certificates (trusted certificates). Edit [letsencrypt-issuer.yaml](app/cluster-issuer/letsencrypt-issuer.yaml) to switch the Let's Encrypt ClusterIssuer from staging certificates (not trusted) to production certificates (update the ACME server URL) and be mindful of rate limits of production certificates.
5. Configure DNS records for all required hostnames after (or while) obtaining the Ingress controller public IP. Do this early so Let's Encrypt can validate domains for certificate issuance.

## Accessing the Kubernetes Cluster

Place (or generate) your `kubeconfig.yml` in one of:
- `kubectl_setup\kube\kubeconfig.yml` (kubectl bootstrap)
- `terraform_setup\kube\kubeconfig.yml` (Terraform bootstrap)

## Bootstrapping Deployment

Choose a bootstrap path:
- For **kubectl**, continue in [kubectl_setup](kubectl_setup).
- For **Terraform**, continue in [terraform_setup](terraform_setup).

> Argo CD may take several minutes to become fully ready. You can monitor progress via the [Argo CD Dashboard on localhost](app/readme.md#argo_cd_dashboard_on_localhost).

For details about what is installed, see the [app](app) folder.
> It takes some time from bootstrap deployment is done until Argo CD is ready. You can follow the status via the [Argo CD Dashboard on localhost](app/readme.md#argo_cd_dashboard_on_localhost).

For further details about what is installed, please see the [app](app) folder.
