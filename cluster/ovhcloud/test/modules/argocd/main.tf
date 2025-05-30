# https://argo-cd.readthedocs.io/en/stable/getting_started/
# https://argoproj.github.io/cd/
# https://argo-cd.readthedocs.io/
# https://argoproj.github.io/argo-helm/
# https://github.com/argoproj/argo-helm
# https://artifacthub.io/packages/helm/argo/argo-cd
# https://medium.com/transmit-security-engineering/building-argocd-ecosystem-with-secret-management-the-gitops-way-part-i-49b4921f7c1f

resource "helm_release" "argocd" {
  name                = "argocd"
  namespace           = "argocd"
  create_namespace    = true
  dependency_update   = true
  repository          = "https://argoproj.github.io/argo-helm"  
  chart               = "argo-cd"
  version             = "8.0.12"
  cleanup_on_fail     = true

  // Argo admin password
  set {
    name  = "configs.secret.argocdServerAdminPassword"
    value = "${bcrypt(var.admin_password)}"
  }
}

data "http" "argocd-application" {
  url = "https://raw.githubusercontent.com/ITfoxtec/FoxIDs.Kubernetes-CD/refs/heads/main/app/${var.environment}/meta-application.yaml"
}

resource "kubectl_manifest" "argocd-application" {
  yaml_body = data.http.argocd-application.response_body
   
  depends_on = [ helm_release.argocd ]
}