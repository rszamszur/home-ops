"""This module contains macro for fetching required teraform providers.
"""

load("@tf_modules//rules:provider.bzl", "remote_terraform_provider")

def ovh_module_terraform_providers():
    remote_terraform_provider(
        name = "provider_ovh_ovh",
        namespace = "ohv",
        type = "ovh",
        version = "2.4.1",

        url_by_platform = {
            "linux_amd64": "https://github.com/ovh/terraform-provider-ovh/releases/download/v0.50.0/terraform-provider-ovh_0.50.0_linux_amd64.zip",
            "darwin_amd64": "https://github.com/ovh/terraform-provider-ovh/releases/download/v0.50.0/terraform-provider-ovh_0.50.0_darwin_amd64.zip",
        },
        sha256_by_platform = {
            "linux_amd64": "37a1dc197d9fc68cc1c90b8ef77411797c4bc494b528ad4880e6ee4185f1eddb",
            "darwin_amd64": "6f61600d81b4c5c0a016d58c2dae7ca4bfaef28481abc12797bc7e90f9c7d3f8",
        },
    )