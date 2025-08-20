# FoxIDs Multi Node Application Deployment

This folder contains the Argo CD GitOps application manifests that together deploy the full multi node FoxIDs environment.

## What Is Installed

Stateless / Ingress exposed:
- FoxIDs (public identity / token service)
- FoxIDs Control (administration & management UI / APIs)
- Argo CD (GitOps controller UI / API)
- (Optional) OpenSearch Dashboards (if enabled)

Stateful (clustered data services):
- MongoDB replica set (FoxIDs data persistence)
- OpenSearch cluster (audit / log / search storage)

Supporting / internal Kubernetes objects:
- Namespaces (segregation of control, data, apps)
- Ingress objects and TLS secrets
- ConfigMaps / Secrets (app configuration & credentials)
- StatefulSets, Deployments, Services, ServiceAccounts, RBAC
- Horizontal / Vertical scaling policies (where applicable)

## Default Domains (replace test-multi-nodes.foxids.com)

Search and replace the placeholder domain per the parent README instructions.

Suggested hostnames:
- FoxIDs: ids.test-multi-nodes.foxids.com
- FoxIDs Control: control.test-multi-nodes.foxids.com
- Argo CD (optional): argocd.admin.test-multi-nodes.foxids.com
- OpenSearch Dashboards (optional): opensearch.admin.test-multi-nodes.foxids.com

## Topology & High Availability

- Application pods (FoxIDs / Control) are stateless and horizontally scalable; scale replicas for throughput.
- MongoDB runs as a replica set (multiple pods) to provide failover and read scalability.
- OpenSearch runs as a multi node cluster for shard distribution and resilience.
- Ingress routes external traffic; TLS termination typically occurs at the ingress controller (configure certs via Secret or cert-manager).
- Secrets for credentials (MongoDB, OpenSearch, Argo CD admin, SMTP/SMS if enabled) are injected; keep them out of VCS or rotate via your secret manager.

## GitOps Flow

1. Cluster bootstrapped (kubectl or Terraform as described in ../README.md).
2. Argo CD installed and pointed at this repository path.
3. Argo CD continuously reconciles:
   - Application definitions (App / AppProject CRDs)
   - Underlying Kubernetes manifests / Helm charts
4. Changes committed here propagate automatically to the cluster (pull model).

## Scaling & Tuning

- Increase FoxIDs / Control replicas to handle authentication peak load.
- Tune MongoDB resource requests / storage class for IOPS appropriate to tenant volume.
- Adjust OpenSearch heap, node count, and shard counts for expected audit/log volume.
- Apply resource limits to prevent noisy neighbor effects in shared clusters.

## Operational Notes

- Rotate admin / root passwords regularly (Argo CD, MongoDB, OpenSearch).
- Monitor cluster health (Argo CD app statuses, MongoDB replica state, OpenSearch green status).
- Backup MongoDB and OpenSearch indices per your retention policies.
- Implement network policies if you need to restrict east-west traffic.

## Troubleshooting

Start by connection to Argo CD Dashboard on localhost with port-forwarding, then check application statuses and logs.  
Run:
```
kubectl port-forward svc/argocd-server -n argocd 3443:443
```
Connect to Argo CD  Dashboard on https://localhost:3443  
    username: admin  
    Password: --> terraform.tfvars --> argocd-admin-password

### Common Issues

- Argo CD app OutOfSync: inspect diff, ensure branch / path correct.
- Pods Pending: verify storage class / resource quotas.
- Ingress 404: confirm hostnames & DNS propagation; check ingress controller logs.
- Authentication issues: confirm FoxIDs Control reachable and MongoDB connectivity.


# Kubectl on Windows
Path to kubernetes config

```
$env:KUBECONFIG="..\kubectl_setup\.kube\kubeconfig.yml"
```
or 
```
$env:KUBECONFIG="..\terraform_setup\.kube\kubeconfig.yml"
```
depending on which bootstrap method you choose.