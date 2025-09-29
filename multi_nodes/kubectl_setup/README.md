# Kubectl

Bootstrap the FoxIDs multi-node stack with plain `kubectl` + `kustomize`.

## Prerequisites
- `kubectl` 1.27+ (or any release with `kubectl apply -k` support).
- Optional: standalone `kustomize` binary if you prefer `kustomize build`.
- A kubeconfig with cluster-admin access. Place it in `.kube\kubeconfig.yml` (same convention as the Terraform walkthrough) or point `KUBECONFIG` to the file.
- A tool that can generate bcrypt hashes (the example below uses `htpasswd`).

## Configure secrets and credentials
1. **FoxIDs data plane secrets** - Edit `foxids-secrets.yaml` and replace every `CHANGE_ME_...` value with strong passwords. Delete the SMTP/SMS sections if you do not use them.
2. **Argo CD admin password** - Generate a bcrypt hash and timestamp, then update `argocd/admin-secret-patch.yaml`.
   ```powershell
   htpasswd.exe -nbBC 10 "" "MyStrongPassword" | ForEach-Object { $_.Split(':')[1] }
   ```
   Copy the resulting hash into `admin.password`. Set `admin.passwordMtime` to the current UTC time in RFC3339 (e.g. `2025-09-28T20:30:00Z`).
3. **Git repository access** -
   - Public HTTPS repo: leave `username`/`password` empty in `argocd/repo-secret.yaml`.
   - Private HTTPS repo: set `url`, `username`, and `password` accordingly.
   - SSH: remove `argocd/repo-secret.yaml` from `argocd/kustomization.yaml` and configure Argo CD per your ssh key workflow.
4. **Meta application source** - If you forked the manifests, update `repoURL` (and optionally `targetRevision`) in `argocd/meta-application.yaml`.

## Apply the manifests
```powershell
kubectl apply -k multi_nodes/kubectl_setup
```

Verify the rollout:
```powershell
kubectl get pods -n argocd
kubectl get pods -n foxids
```

After the Argo CD controllers start, the `meta-application` will sync every manifest under `multi_nodes/app` (matching the Terraform-driven workflow).

## Cleanup
To remove everything created by this kustomization:
```powershell
kubectl delete -k multi_nodes/kubectl_setup
```

## Notes
- The Argo CD upstream bundle referenced in `argocd/kustomization.yaml` is pinned to `v2.11.0`. Update the URL when upgrading Helm chart versions in the Terraform setup.
- Secrets are stored in plaintext inside the repository by default. Prefer copying this folder and committing your real credentials to a private repo, or template the files through your secret management process before running `kubectl apply -k`.

