load("@tf_modules//:def.bzl", "terraform_module")

genrule(
    name = "secrets_file",
    outs = ["secrets.auto.tfvars"],
    srcs = ["secrets.auto.tfvars.age"],
    tools = [
      "@age//:bin"
    ],
    cmd = """
set -euo pipefail
./$(location @age//:bin) -d -i $$AGE_IDENTITY_KEY $(location :secrets.auto.tfvars.age) > $@
""",
)

terraform_module(
    name = "nodes",
    srcs = [":secrets_file"] + glob(["*.tf"]),
    terraform_executable = "@terraform_toolchain-1.7.3//:terraform_executable",
)
