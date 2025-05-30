variable environment {
    type        = string
    default     = "test"
}

variable ovh_service_name {
    type        = string
}
variable ovh_vlan_id {
    type        = string
}
variable ovh_region {
    type        = string
}

variable ovh_application_key {
    type        = string
    sensitive   = true
}
variable ovh_application_secret {
    type        = string
    sensitive   = true
}
variable ovh_consumer_key {
    type        = string
    sensitive   = true
}

variable argocd_admin_password {
  type        = string
  sensitive   = true
}

variable letsencrypt_email {
  type        = string
}
variable cloudflare_email {
  type        = string
}
variable cloudflare_api_token {
  type        = string
  sensitive   = true
}
