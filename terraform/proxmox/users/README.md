# Terraform: Proxmox users module

This Terraform module manages Proxmox VE users.

## Import state

```shell
terraform init
terraform import proxmox_virtual_environment_group.puqu-team puqu
terraform import proxmox_virtual_environment_role.puqu-admin puqu-admin
terraform import proxmox_virtual_environment_user.puqu-user[\"r2r\"] r2r
terraform import proxmox_virtual_environment_user.puqu-user[\"alex\"] alex
terraform import proxmox_virtual_environment_user.puqu-user[\"suwara\"] suwara
terraform import proxmox_virtual_environment_user.puqu-user[\"konrad\"] konrad
```
