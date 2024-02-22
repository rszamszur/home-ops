dns_records = {
  "pkleague.pl" : [
    {
      fieldtype = "TXT"
      target    = "protonmail-verification=f72bba0b676313ba513874f152e45144d80aa7f4"
    },
    {
      fieldtype = "MX"
      target    = "20 mailsec.protonmail.ch."
    },
    {
      fieldtype = "MX"
      target    = "10 mail.protonmail.ch."
    },
    {
      fieldtype = "TXT"
      target    = "v=spf1 include:_spf.protonmail.ch ~all"
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail._domainkey"
      target    = "protonmail.domainkey.dih24c6i4no3ngdepkkqgsqf6ckt4vxbi2kwha7ldpd43iqh35yza.domains.proton.ch."
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail2._domainkey"
      target    = "protonmail2.domainkey.dih24c6i4no3ngdepkkqgsqf6ckt4vxbi2kwha7ldpd43iqh35yza.domains.proton.ch."
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail3._domainkey"
      target    = "protonmail3.domainkey.dih24c6i4no3ngdepkkqgsqf6ckt4vxbi2kwha7ldpd43iqh35yza.domains.proton.ch."
    },
    {
      fieldtype = "TXT"
      subdomain = "_dmarc"
      target    = "v=DMARC1; p=quarantine"
    }
  ],
  "mlipiec.pl" = [
    {
      fieldtype = "TXT"
      target    = "protonmail-verification=34a8fa99d62e94d82147647ca5683392c5e71a9d"
    },
    {
      fieldtype = "MX"
      target    = "20 mailsec.protonmail.ch."
    },
    {
      fieldtype = "MX"
      target    = "10 mail.protonmail.ch."
    },
    {
      fieldtype = "TXT"
      target    = "v=spf1 include:_spf.protonmail.ch ~all"
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail._domainkey"
      target    = "protonmail.domainkey.dnzfmeegtqt7bmahjveaekb6utn46n3i2rmnw7x34zcjb3ghz7vma.domains.proton.ch."
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail2._domainkey"
      target    = "protonmail2.domainkey.dnzfmeegtqt7bmahjveaekb6utn46n3i2rmnw7x34zcjb3ghz7vma.domains.proton.ch."
    },
    {
      fieldtype = "CNAME"
      subdomain = "protonmail3._domainkey"
      target    = "protonmail3.domainkey.dnzfmeegtqt7bmahjveaekb6utn46n3i2rmnw7x34zcjb3ghz7vma.domains.proton.ch."
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
      target    = "20 mailsec.protonmail.ch."
    },
    {
      fieldtype = "MX"
      target    = "10 mail.protonmail.ch."
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