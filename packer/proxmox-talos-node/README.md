# Build talos-node vm template

## Using packer

Prerequsites:

* Bazel

```shell
bazel run :init --action_env=AGE_IDENTITY_KEY=<PATH_TO_AGE_KEY>
bazel run :build --action_env=AGE_IDENTITY_KEY=<PATH_TO_AGE_KEY>
```

## Resources

* https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox/latest/components/builder/iso
