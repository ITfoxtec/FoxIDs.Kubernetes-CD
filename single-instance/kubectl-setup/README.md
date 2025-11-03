# Kubectl (Single-Instance Bootstrap)

Use this folder to bootstrap the FoxIDs single-instance stack with `kubectl`.

## Prerequisites
- `kubectl` 1.27+ (or any version that supports `kubectl apply -k`).
- Optional: stand-alone `kustomize` binary if you prefer `kustomize build`.
- A kubeconfig with cluster-admin privileges. Place it in `.kube\kubeconfig.yml` or set `KUBECONFIG` before running commands.

# Kubectl on Windows
Path to kubernetes config
```
$env:KUBECONFIG=".kube\kubeconfig.yml"
```

## Configure Secrets and Credentials
1. Edit `foxids-secrets.yaml` and replace every `CHANGE_ME_...` value with strong passwords. Remove the SMTP / SMS secret blocks if you do not use them.
2. Run a bcrypt hash generator (for example `htpasswd`) and update `argocd/admin-secret-patch.yaml`:
   - Set `admin.password` to the bcrypt hash.
   - Set `admin.passwordMtime` to the current UTC timestamp in RFC3339 format.
3. Update `argocd/repo-secret.yaml` if Argo CD needs credentials to pull your Git repository (leave `username` / `password` empty for public HTTPS access).
4. Adjust `argocd/meta-application.yaml` if you forked the repository or want to track a different branch.

## Apply the Manifests
From the repository root run:

```
kubectl apply -k single-instance/kubectl-setup
```

Monitor progress:

```
kubectl get pods -n argocd
kubectl get pods -n foxids
```

When Argo CD is ready, port-forward the server and sign in with the admin password you configured:

```
kubectl port-forward svc/argocd-server -n argocd 3443:443
```

Log on at https://localhost:3443 and ensure every application sourced from `single-instance/app` reports `Healthy/Synced`.

## Cleanup
Remove the stack when finished testing:

```
kubectl delete -k single-instance/kubectl-setup
```

> Need higher availability later? Switch the Argo CD meta application back to `ha-cluster/app` to reconcile the HA-cluster manifests instead.





