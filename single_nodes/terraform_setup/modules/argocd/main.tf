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

  # Argo admin password
  set {
    name  = "configs.secret.argocdServerAdminPassword"
    value = "${bcrypt(var.admin-password)}"
  }
}

resource "kubernetes_secret" "argocd-secret" {
  count = var.git-repo-username != "" ? 1 : 0

  metadata {
    name = "argocd-secret"
    namespace = "argocd"
  }

  data = {
    type = "helm"
    url = var.git-repo-url
    username = var.git-repo-username
    password = var.git-repo-password
  }

  type = "Opaque"

  depends_on = [ helm_release.argocd ]  
}

resource "kubectl_manifest" "argocd-meta-application" {
  yaml_body = templatefile("${path.module}/meta-application.yaml", {
      url = base64encode(var.git-repo-url)
    })

  depends_on = [ kubernetes_secret.argocd-secret ]  
}