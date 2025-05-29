# https://argoproj.github.io/cd/
# https://argo-cd.readthedocs.io/
# https://argoproj.github.io/argo-helm/
# https://github.com/argoproj/argo-helm
# https://artifacthub.io/packages/helm/argo/argo-cd

resource "helm_release" "argocd" {
    name                = "argocd"
    namespace           = "argocd"
    create_namespace    = true
    dependency_update   = true
    repository          = "https://argoproj.github.io/argo-helm"  
    chart               = "argo-cd"
    version             = "8.0.12"
    cleanup_on_fail     = true
}

data "http" "argocd-application" {
  url = "https://github.com/ITfoxtec/FoxIDs.Kubernetes-CD/blob/main/environments/${var.environment}/application.yaml"
}

resource "kubectl_manifest" "argocd-application" {
  yaml_body = data.http.argocd-application.body
   
  depends_on = [ helm_release.argocd ]
}