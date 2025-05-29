output "kubeconfig_file" {
    value     = ovh_cloud_project_kube.my_cluster.kubeconfig
    sensitive = true
}
