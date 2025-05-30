resource "kubernetes_namespace" "foxids-ns" {
  metadata {
    name = "foxids"

    labels = {
      "istio.io/dataplane-mode" = "ambient"
    }
  }
}

resource "random_password" "mongodb-root-password" {
  length = 40
  special = true
}
resource "random_password" "mongodb-replica-set-key" {
  length = 40
  special = true
}
resource "random_password" "mongodb-foxids-password" {
  length = 40
  special = true
}
resource "random_password" "mongodb-foxids-web-password" {
  length = 40
  special = true
}

resource "kubernetes_secret" "cloudflare-api-secret" {
  metadata {
    name = "cloudflare-api-token"
  }

  data = {
    mongodb-root-password = random_password.mongodb-root-password.result
    mongodb-replica-set-key = random_password.mongodb-replica-set-key.result
    mongodb-password = "${random_password.mongodb-foxids-password.result},${random_password.mongodb-foxids-web-password.result}"
  }

  type = "Opaque"

  depends_on = [ kubernetes_namespace.foxids-ns ] 
}