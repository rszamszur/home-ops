load("@home-ops//bazel/rules/rules_packer:packer.bzl", "packer_init", "packer_build")

filegroup(
  name = "srcs",
  srcs = glob(["**/*.hcl"]),
)

genrule(
  name = "secrets_file",
  outs = ["secrets.auto.pkrvars.hcl"],
  srcs = ["secrets.auto.pkrvars.hcl.age"],
  tags = ["local", "no-cache", "no-remote-cache", "age-secret"],
  tools = [
    "@age//:bin"
  ],
  cmd = """
set -euo pipefail
./$(location @age//:bin) -d -i $$AGE_IDENTITY_KEY $(location :secrets.auto.pkrvars.hcl.age) > $@
""",
)

packer_init(
  name = "packer.init",
  data = [":srcs"],
  tags = ["local"],
)

packer_build(
  name = "packer.build",
  data = [":srcs", ":secrets_file"],
  tags = ["local", "age-secret"],
  options = [
    "-only=vm-template.proxmox-iso.talos-node"
  ],
)
