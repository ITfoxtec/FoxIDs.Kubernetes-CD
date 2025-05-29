module "argocd" {
  source = "./modules/argocd/"

  depends_on = [ ovh_cloud_project_kube_nodepool.node_pool_1 ] 
}
