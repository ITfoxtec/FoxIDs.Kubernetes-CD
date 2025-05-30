variable environment {
  type        = string
}
variable domain {
  type        = string
}

variable admin_password {
  type        = string
  sensitive   = true
}

variable letsencrypt_email {
  type        = string
}
variable cloudflare_email {
  type        = string
}

variable subnet_list {
  type        = string
}