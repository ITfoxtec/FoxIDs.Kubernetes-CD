module "ovh-single-cloud" {
    source        = "./modules/ovh-single-cloud/"
    service_name  = var.ovh_service_name
    vlan_id       = var.ovh_vlan_id
    network       = var.ovh_network
    network_start = var.ovh_network_start
    network_end   = var.ovh_network_end
    region        = var.ovh_region
}

module "cert-manager" {
    source               = "./modules/cert-manager/"
    cloudflare_api_token = var.cloudflare_api_token

    depends_on           = [ module.ovh-single-cloud ] 
}

module "argocd" {
    source            = "./modules/argocd/"
    environment       = var.environment
    domain            = var.domain
    admin_password    = var.argocd_admin_password
    letsencrypt_email = var.letsencrypt_email
    cloudflare_email  = var.cloudflare_email
    subnet_list       = var.ovh_network

    depends_on     = [ module.cert-manager ] 
}
