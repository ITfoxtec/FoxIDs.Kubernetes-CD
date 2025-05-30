module "ovh-single-cloud" {
    source       = "./modules/ovh-single-cloud/"
    service_name = var.ovh_service_name
    vlan_id      = var.ovh_vlan_id
    region       = var.ovh_region
}

module "cert-manager" {
    source       = "./modules/cert-manager/"
    cloudflare-api-token  = var.cloudflare-api-token

    depends_on   = [ module.ovh-single-cloud ] 
}

module "argocd" {
    source       = "./modules/argocd/"
    environment  = var.environment

    depends_on   = [ module.cert-manager ] 
}
