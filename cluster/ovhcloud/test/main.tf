module "ovh-single-cloud" {
    source       = "./modules/ovh-single-cloud/"
    service_name = var.ovh_service_name
    vlan_id      = var.ovh_vlan_id
    region       = var.ovh_region
}

module "cert-manager" {
    source               = "./modules/cert-manager/"
    letsencrypt_email    = var.letsencrypt_email
    cloudflare_email     = var.cloudflare_email
    cloudflare_api_token = var.cloudflare_api_token

    depends_on           = [ module.ovh-single-cloud ] 
}

module "argocd" {
    source         = "./modules/argocd/"
    environment    = var.environment
    admin_password = var.argocd_admin_password

    depends_on     = [ module.cert-manager ] 
}
