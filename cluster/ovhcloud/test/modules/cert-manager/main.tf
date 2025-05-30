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