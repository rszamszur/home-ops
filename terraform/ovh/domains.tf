locals {
  dns_records = { for k in flatten([
    for zone, records in var.dns_records : [
      for i in range(length(records)) : {
        id : "${zone}-${i}"
        zone : zone
        subdomain : lookup(try(records[i], {}), "subdomain", "")
        ttl : lookup(try(records[i], {}), "ttl", 60)
        fieldtype : records[i]["fieldtype"]
        target : records[i]["target"]
      }
    ]
  ]) : k.id => k }
}

resource "ovh_domain_zone_record" "ovh_dns_records" {
  for_each  = local.dns_records
  zone      = each.value.zone
  subdomain = each.value.subdomain
  fieldtype = each.value.fieldtype
  ttl       = each.value.ttl
  target    = each.value.target
}
