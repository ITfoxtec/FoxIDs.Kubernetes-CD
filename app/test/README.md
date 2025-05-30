# Monitoring

## Argo CD  Dashboard
https://argo-cd.readthedocs.io/en/stable/getting_started/

### Get admin secret
You need to run the `kubectl get secret...` in Linux.

Start Linux prompt  
https://learn.microsoft.com/en-us/windows/wsl/bas
```
wsl
```

Path to kubernetes config
```
export KUBECONFIG=.kube/kubeconfig.yml
```

If not installed, install `kubectl`, then `exit` and open `wsl` again.
```
sudo snap install kubectl --classic
```

Get `admin` user's password
```
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
```

### Open Argo CD 
https://localhost:3443

```
kubectl port-forward svc/argocd-server -n argocd 3443:443
```

## Access Grafana Dashboard

http://localhost:3000

Admin user
```
Username: admin
First login password: admin
```
kubectl port-forward svc/grafana -n monitoring 3000:80
```

Set Prometheus connection URL: `http://prometheus-server.monitoring.svc.cluster.local`

Grafana supports prebuilt dashboards for Istio. The recommended Dashboard IDs are listed below:

- Istio Mesh Dashboard: 7645
- Istio Workload Dashboard: 7639
- Istio Performance: 11829


## Access Prometheus Dashboard

http://localhost:9090

```
kubectl port-forward svc/prometheus-server -n monitoring 9090:80
```

## Access Kiali Dashboard

http://localhost:20001

```
kubectl port-forward service/kiali -n istio-system 20001:20001
```

