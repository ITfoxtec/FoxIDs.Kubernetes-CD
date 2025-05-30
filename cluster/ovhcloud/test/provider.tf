terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
    }
  }
}

provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

provider "helm" {
  kubernetes {
    host                    = module.ovh-single-cloud.host
    client_certificate      = base64decode(module.ovh-single-cloud.client_certificate)
    client_key              = base64decode(module.ovh-single-cloud.client_key)
    cluster_ca_certificate  = base64decode(module.ovh-single-cloud.cluster_ca_certificate)
  }
}

provider "kubectl" {
  host                    = module.ovh-single-cloud.host
  client_certificate      = base64decode(module.ovh-single-cloud.client_certificate)
  client_key              = base64decode(module.ovh-single-cloud.client_key)
  cluster_ca_certificate  = base64decode(module.ovh-single-cloud.cluster_ca_certificate)
  load_config_file        = false
}
