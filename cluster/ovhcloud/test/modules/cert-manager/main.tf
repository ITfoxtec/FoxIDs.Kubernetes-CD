resource "kubernetes_secret" "cloudflare-api-secret" {
  metadata {
    name = "cloudflare-api-token"
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"
}

resource "kubectl_manifest" "letsencrypt-kustomize" {
  yaml_body = templatefile("${path.module}/letsencrypt-kustomize.yaml", {  
      letsencrypt_email = var.letsencrypt_email,
      cloudflare_email  = var.cloudflare_email
    })
}