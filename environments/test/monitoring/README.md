## Access Grafana Dashboard

http://localhost:3000

Admin user
```
Username: admin
Default password: prom-operator
```

```
kubectl port-forward svc/prometheus-stack-grafana -n monitoring 3000:80
```

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

### Get Service Account token
Start Linux prompt
```
wsl
```

Path to kubernetes config
```
export KUBECONFIG=.kube/kubeconfig.yml
```

Get admin users password
```

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode

kubectl get secret istio-ca-secret -n istio-system -o jsonpath="{.data.token}" | base64 --decode

$(kubectl get sa kiali -n istio-system -o "jsonpath={.secrets[0].name}") -o jsonpath={.data.token} | base64 -d


kubectl get secret -n istio-system $(kubectl get sa istio-ca-secret -n istio-system -o "jsonpath={.secrets[0].name}") -o jsonpath={.data.token} | base64 -d



kubectl -n istio-system create token kiali-service-account

```

