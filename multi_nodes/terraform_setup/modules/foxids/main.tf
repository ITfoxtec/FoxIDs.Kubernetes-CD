resource "kubernetes_namespace" "foxids-ns" {
  metadata {
    name = "foxids"
  }
}

resource "kubernetes_secret" "mongodb-secret" {
  metadata {
    name = "mongodb-secret"
    namespace = "foxids"
  }

  data = {
    mongodb-root-password = var.mongodb-root-password
    mongodb-foxids-password = var.mongodb-foxids-password
  }

  type = "Opaque"

  depends_on = [ kubernetes_namespace.foxids-ns ] 
}

resource "kubernetes_secret" "opensearch-secret" {
  metadata {
    name = "opensearch-secret"
    namespace = "foxids"
  }

  data = {
    opensearch-password = var.opensearch-password
  }

  type = "Opaque"

  depends_on = [ kubernetes_namespace.foxids-ns ] 
}

resource "kubernetes_secret" "smtp-secret" {
  count = var.smtp-username != "" ? 1 : 0

  metadata {
    name = "smtp-secret"
    namespace = "foxids"
  }

  data = {
    smtp-username = var.smtp-username
    smtp-password = var.smtp-password
  }

  type = "Opaque"

  depends_on = [ kubernetes_namespace.foxids-ns ] 
}

resource "kubernetes_secret" "sms-secret" {
  count = var.sms-secret != "" ? 1 : 0

  metadata {
    name = "sms-secret"
    namespace = "foxids"
  }

  data = {
    sms-secret = var.sms-secret
  }

  type = "Opaque"

  depends_on = [ kubernetes_namespace.foxids-ns ]  
}