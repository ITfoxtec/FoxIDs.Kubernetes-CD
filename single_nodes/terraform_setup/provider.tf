terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = ".kube/kubeconfig.yml"
  }
}

provider "kubernetes" {
  config_path = ".kube/kubeconfig.yml"
}

provider "kubectl" {
  config_path = ".kube/kubeconfig.yml"
}