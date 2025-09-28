variable argocd-admin-password {
  type        = string
  sensitive   = true
}

variable git-repo-url {
  type        = string
}
variable git-repo-username {
  type        = string
  sensitive   = true
  default     = ""
}
variable git-repo-password {
  type        = string
  sensitive   = true
  default     = ""
}

variable mongodb-root-password {
  type        = string
  sensitive   = true
}
variable mongodb-foxids-password {
  type        = string
  sensitive   = true
}

variable opensearch-admin-password {
  type        = string
  sensitive   = true
}
variable opensearch-dashbord-connect-password {
  type        = string
  sensitive   = true
}

variable smtp-username {
  type        = string
  sensitive   = true
  default     = ""
}
variable smtp-password {
  type        = string
  sensitive   = true
  default     = ""
}

variable sms-secret {
  type        = string
  sensitive   = true
  default     = ""
}