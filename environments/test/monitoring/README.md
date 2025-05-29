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