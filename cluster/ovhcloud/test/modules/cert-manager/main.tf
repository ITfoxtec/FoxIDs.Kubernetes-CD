resource "kubectl_manifest" "cloudflare-api-secret" {
  yaml_body = templatefile("${path.module}/cloudflare-api-token-secret.yaml", {
      api-token = base64encode(var.cloudflare-api-token)
    })
}