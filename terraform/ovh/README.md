# OVH

Create application secret via: https://api.ovh.com/createToken/?GET=/*&POST=/*&PUT=/*&DELETE=/*

To list all generated applications use: https://eu.api.ovh.com/console/?section=%2Fme&branch=v1#get-/me/api/application
For deletion use: https://eu.api.ovh.com/console/?section=%2Fme&branch=v1#delete-/me/api/application/-applicationId-

## Import

Each record needs to be imported individualy. For example:

```shell
terraform import ovh_domain_zone_record.ovh_dns_records[\"rsd.sh-0\"] <DNS_RECORD_ID>.rsd.sh
```

Where `DNS_RECODR_ID` can be obrained from https://eu.api.ovh.com/console/?section=%2Fdomain&branch=v1#get-/domain/zone/-zoneName-/record/-id-
To get all available zone record ids call: https://eu.api.ovh.com/console/?section=%2Fdomain&branch=v1#get-/domain/zone/-zoneName-/record
