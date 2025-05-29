## Access Grafana Dashboard

http://localhost:3000

```
kubectl port-forward svc/grafana -n monitoring 3000:80
```

## Access Prometheus Dashboard

http://localhost:9090

```
kubectl port-forward svc/prometheus-server -n monitoring 9090:80
```