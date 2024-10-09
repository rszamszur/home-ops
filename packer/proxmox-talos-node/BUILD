load("@home-ops//bazel/rules/rules_packer:packer.bzl", "packer_init", "packer_build")

genrule(
    name = "secrets_file",
    outs = ["secrets.auto.pkrvars.hcl"],
    srcs = ["secrets.auto.pkrvars.hcl.age"],
    tools = [
      "@age//:bin"
    ],
    cmd = """
set -euo pipefail
./$(location @age//:bin) -d -i $$AGE_IDENTITY_KEY $(location :secrets.auto.pkrvars.hcl.age) > $@
""",
)

packer_init(
    name = "init",
    data = [":secrets_file"] + glob(["**/*.hcl"]),
)

packer_build(
  name = "build",
  data = [":secrets_file"] + glob(["**/*.hcl"]),
  options = [
    "-only=vm-template.proxmox-iso.talos-node"
  ],
)