resource "kubectl_manifest" "ingress-kustomize" {
  yaml_body = file("${path.module}/ingress-kustomize.yaml")
}