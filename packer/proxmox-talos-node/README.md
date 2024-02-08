# Build talos-node vm template

## Using packer

Prerequsites:

* Packer
* Decrypt `secrets.auto.pkvars.hcl.age`
* Make (optional)

```shell
make init
make build
```

## Resources

* https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox/latest/components/builder/iso
