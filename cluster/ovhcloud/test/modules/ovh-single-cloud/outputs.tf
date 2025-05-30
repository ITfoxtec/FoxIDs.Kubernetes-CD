resource "local_file" "kubeconfig_file" {
  content  = ovh_cloud_project_kube.single_cluster.kubeconfig
  filename = ".kube/kubeconfig.yml"
}

output "host" {
  value = ovh_cloud_project_kube.single_cluster.kubeconfig_attributes[0].host
  sensitive = true
}
output "client_certificate" {
  value = ovh_cloud_project_kube.single_cluster.kubeconfig_attributes[0].client_certificate
  sensitive = true
}
output "client_key" {
  value = ovh_cloud_project_kube.single_cluster.kubeconfig_attributes[0].client_key
  sensitive = true
}
output "cluster_ca_certificate" {
  value = ovh_cloud_project_kube.single_cluster.kubeconfig_attributes[0].cluster_ca_certificate
  sensitive = true
}