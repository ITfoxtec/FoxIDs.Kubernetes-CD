variable environment {
    type        = string
}
variable domain {
    type        = string
}

variable ovh_service_name {
    type        = string
}
variable ovh_vlan_id {
    type        = string
}
variable ovh_network {
    type        = string
    default     = "192.168.168.0/24"
}
variable ovh_network_start {
    type        = string
    default     = "192.168.168.100"
}
variable ovh_network_end {
    type        = string
    default     = "192.168.168.200"
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
