# FoxIDs Single Node Application Deployment

This folder contains the Argo CD application manifests that stand up the single-node FoxIDs environment.

## Components

Stateless services exposed via ingress:
- FoxIDs (public identity / token service)
- FoxIDs Control (administration UI / APIs)
- Argo CD (GitOps controller UI / API)
- OpenSearch Dashboards (optional)

Stateful backing services (single pod each):
- MongoDB (primary data store for FoxIDs)
- OpenSearch (audit and log storage)

Supporting infrastructure:
- Namespaces, Services, Ingresses, TLS certificates via cert-manager
- Secrets populated through Terraform or manual kubectl applies
- StatefulSets, Deployments, and ConfigMaps described in this repo

## GitOps Flow

1. Bootstrap the cluster (kubectl or Terraform as described one level up).
2. Deploy Argo CD and point it at `single_nodes/app`.
3. Argo CD continuously reconciles every manifest in this directory.
4. Push updates to Git to roll out configuration changes.

## Monitoring

- Port-forward Argo CD (`kubectl port-forward svc/argocd-server -n argocd 3443:443`) to monitor sync status.
- Check the MongoDB and OpenSearch StatefulSets in namespace `foxids` for pod health.
- Inspect Ingress resources when validating DNS and TLS issuance.

## Access URLs (replace domain placeholders)

- FoxIDs: `https://id.test-single-nodes.foxids.com`
- FoxIDs Control: `https://control.test-single-nodes.foxids.com`
- Argo CD: `https://argocd.test-single-nodes.foxids.com`
- OpenSearch Dashboards: `https://opensearch.test-single-nodes.foxids.com`