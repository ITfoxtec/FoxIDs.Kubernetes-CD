# Kubectl (Single-Node Bootstrap)

This folder documents how to bootstrap the FoxIDs single-node stack with `kubectl`. Reuse the multi-node kustomization (`multi_nodes/kubectl_setup`) as a starting point and adjust it to reference the manifests in `single_nodes/app`.

## Prerequisites
- `kubectl` 1.27+ (or any version that supports `kubectl apply -k`).
- Optional: the standalone `kustomize` binary if you prefer `kustomize build`.
- A kubeconfig with cluster-admin privileges. Place it in `.kube\kubeconfig.yml` or set `KUBECONFIG` before running commands.

## Preparation

1. Copy `multi_nodes/kubectl_setup` to a working directory (for example `_local/single-node-kubectl`).
2. Update secrets and credentials in the copied files:
   - `foxids-secrets.yaml` - replace every `CHANGE_ME_...` value with strong passwords (FoxIDs, MongoDB, OpenSearch, SMTP/SMS as needed).
   - `argocd/admin-secret-patch.yaml` - generate a bcrypt hash for the Argo CD admin password, update `admin.password`, and set `admin.passwordMtime` to the current UTC timestamp.
   - `argocd/repo-secret.yaml` - configure Argo CD access to your Git repository.
3. Point the Argo CD meta application at the single-node manifests by editing `argocd/meta-application.yaml`:
   - `repoURL: https://github.com/ITfoxtec/FoxIDs.Kubernetes-CD.git`
   - `path: single_nodes/app`

## Apply the Manifests

From the repository root (or from your working directory):

```
kubectl apply -k <path-to-your-single-node-kustomization>
```

Wait for Argo CD to become ready:

```
kubectl get pods -n argocd
kubectl get pods -n foxids
```

Then port-forward the Argo CD server and verify that every application under `single_nodes/app` is `Synced` and `Healthy`.

```
kubectl port-forward svc/argocd-server -n argocd 3443:443
```

Log on at https://localhost:3443 with the admin password you configured.

## Cleanup

Delete the resources when finished:

```
kubectl delete -k <path-to-your-single-node-kustomization>
```

> Need high availability later? Switch the Argo CD meta application back to `multi_nodes/app` to reconcile the multi-node manifests.