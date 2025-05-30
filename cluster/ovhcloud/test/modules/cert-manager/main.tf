#resource "kubectl_manifest" "cloudflare-api-secret" {
#  yaml_body = templatefile("${path.module}/cloudflare-api-token-secret.yaml", {
#      api-token = base64encode(var.cloudflare-api-token)
#    })
#}

resource "kubernetes_secret" "cloudflare-api-secret" {
  metadata {
    name = "cloudflare-api-token"
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"
}

resource "kubectl_manifest" "letsencrypt-issuer-cloudflare-api" {
  yaml_body = templatefile("${path.module}/letsencrypt-issuer-cloudflare-api.yaml", {
      email = base64encode(var.letsencrypt_email)
      cloudflare_email = base64encode(var.cloudflare_email)
    })
   
  depends_on = [ kubernetes_secret.cloudflare-api-secret ]
}

resource "kubectl_manifest" "letsencrypt-issuer" {
  yaml_body = templatefile("${path.module}/letsencrypt-issuer.yaml", {
      email = base64encode(var.letsencrypt_email)
    })
}