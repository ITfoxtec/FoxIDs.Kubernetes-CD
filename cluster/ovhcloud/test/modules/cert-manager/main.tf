resource "kubernetes_namespace" "cert-manager-ns" {
  metadata {
    name = "cert-manager"
  }
}

resource "kubernetes_secret" "cloudflare-api-secret" {
  metadata {
    name = "cloudflare-api-token"
    namespace = "cert-manager"
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"

  depends_on = [ kubernetes_namespace.cert-manager-ns ]
}

resource "kubectl_manifest" "letsencrypt-kustomize" {
  yaml_body = templatefile("${path.module}/letsencrypt-kustomize.yaml", {  
      letsencrypt_email = var.letsencrypt_email,
      cloudflare_email  = var.cloudflare_email
    })

  depends_on = [ kubernetes_namespace.cert-manager-ns ]
}