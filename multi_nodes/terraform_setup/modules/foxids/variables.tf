variable mongodb-root-password {
  type        = string
  sensitive   = true
}
variable mongodb-replica-set-key {
  type        = string
  sensitive   = true
}
variable mongodb-foxids-password {
  type        = string
  sensitive   = true
}

variable opensearch-password {
  type        = string
  sensitive   = true
}
variable opensearch-dashboards-password {
  type        = string
  sensitive   = true
}

variable smtp-username {
  type        = string
  sensitive   = true
}
variable smtp-password {
  type        = string
  sensitive   = true
}

variable sms-secret {
  type        = string
  sensitive   = true
}