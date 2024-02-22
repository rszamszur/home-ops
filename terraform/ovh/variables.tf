variable "ovh_application_key" {
  description = "OVH application key"
  type        = string
  sensitive   = true
}

variable "ovh_application_secret" {
  description = "OVH application secret"
  type        = string
  sensitive   = true
}

variable "ovh_consumer_key" {
  description = "OVH consumer key"
  type        = string
  sensitive   = true
}

variable "dns_records" {
  description = "OVH DNS records"
  type = map(
    list(
      object({
        fieldtype = string
        target    = string
        subdomain = optional(string)
        ttl       = optional(number)
      })
    )
  )
}
