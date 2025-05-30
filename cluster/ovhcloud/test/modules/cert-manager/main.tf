resource "kubernetes_secret" "cloudflare-api-secret" {
  metadata {
    name = "cloudflare-api-token"
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"
}