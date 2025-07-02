dns_records = {
  "szamszur.cloud" = [
    {
      fieldtype = "TXT"
      target    = "protonmail-verification=c3e3f74d2ab7c6c672ebb123c483c82948d3a215"
    },
    {
      fieldtype = "MX"
      target    = "10 mail.protonmail.ch."
    },
    {
      fieldtype = "MX"
      target    = "20 mailsec.protonmail.ch."
    },
    {
      fieldtype = "TXT"
      target    = "v=spf1 include:_spf.protonmail.ch ~all"
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail._domainkey"
      target    = "protonmail.domainkey.d4g36os6intjutvfx5wsy5k3and4ulum3ahzeow4issuw4ckwj4qa.domains.proton.ch."
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail2._domainkey"
      target    = "protonmail2.domainkey.d4g36os6intjutvfx5wsy5k3and4ulum3ahzeow4issuw4ckwj4qa.domains.proton.ch."
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail3._domainkey"
      target    = "protonmail3.domainkey.d4g36os6intjutvfx5wsy5k3and4ulum3ahzeow4issuw4ckwj4qa.domains.proton.ch."
    },
    {
      fieldtype = "TXT"
      subdomain = "_dmarc"
      target    = "v=DMARC1; p=quarantine"
    }
  ],
  "rsd.sh" = [
    {
      fieldtype = "TXT"
      target    = "protonmail-verification=4544ad63078e05697e2b565791c56b29949459b4"
    },
    {
      fieldtype = "MX"
      target    = "10 mail.protonmail.ch."
    },
    {
      fieldtype = "MX"
      target    = "20 mailsec.protonmail.ch."
    },
    {
      fieldtype = "TXT"
      target    = "v=spf1 include:_spf.protonmail.ch ~all"
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail._domainkey"
      target    = "protonmail.domainkey.dzpd2kyejsct4epru3vvo3t7epet6zpoa4smf5hz4kgo44garfncq.domains.proton.ch."
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail2._domainkey"
      target    = "protonmail2.domainkey.dzpd2kyejsct4epru3vvo3t7epet6zpoa4smf5hz4kgo44garfncq.domains.proton.ch."
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail3._domainkey"
      target    = "protonmail3.domainkey.dzpd2kyejsct4epru3vvo3t7epet6zpoa4smf5hz4kgo44garfncq.domains.proton.ch."
    },
    {
      fieldtype = "TXT"
      subdomain = "_dmarc"
      target    = "v=DMARC1; p=quarantine"
    }
  ],
}