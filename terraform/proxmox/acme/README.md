# Terraform: Proxmox ACME module

This Terraform module provisions and manages both a Let's Encrypt ACME account and the OVH DSN01 ACME plugin.

## Import state

```shell
terraform init
terraform import proxmox_virtual_environment_acme_account.letsencrypt letsencrypt
terraform import proxmox_virtual_environment_acme_dns_plugin.acme-ovh ACME-OVH
```
