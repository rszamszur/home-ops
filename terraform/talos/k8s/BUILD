load("@tf_modules//:def.bzl", "terraform_module")

terraform_module(
    name = "k8s",
    srcs = glob(["*.tf"]),
    terraform_executable = "@terraform_toolchain-1.7.3//:terraform_executable",
    module_deps = [
        "//terraform/talos/nodes",
    ],
)
