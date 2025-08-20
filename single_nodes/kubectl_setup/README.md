# Kubectl

Bootstrap FoxIDs deployment in Kubernetes with `kubectl`.

## Prerequisites
You should have `kubectl` installed.

# Access to Kubernetes cluster

Configure access to you Kubernetes cluster.

Place your clusters `kubeconfig.yml` file in: 
```
.kube\kubeconfig.yml
```

## Bootstrap FoxIDs deployment

Open a command prompt.

In PowerShell add a path to `kubeconfig.yml`.
```
$env:KUBECONFIG=".kube\kubeconfig.yml"
```

xxxxxxxxxx

