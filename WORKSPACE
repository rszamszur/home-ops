workspace(name = "home-ops")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

# Age binary

http_archive(
    name = "age",
    build_file = "@home-ops//bazel/third_party:age.bazel",
    sha256 = "2ae71cb3ea761118937a944083f057cfd42f0ef11d197ce72fc2b8780d50c4ef",
    url = "https://github.com/FiloSottile/age/releases/download/v1.2.0/age-v1.2.0-linux-amd64.tar.gz",
)

# Packer binary

http_archive(
    name = "packer",
    build_file = "@home-ops//bazel/third_party:packer.bazel",
    sha256 = "790183b1febe0f3f919bac22b193dfbba031a6e30a148ecc69816fcc47eec702",
    url = "https://releases.hashicorp.com/packer/1.8.4/packer_1.8.4_linux_386.zip",
)

# Coder binary

http_archive(
    name = "coder",
    build_file = "@home-ops//bazel/third_party:coder.bazel",
    sha256 = "e3cfe8c661b42237204b3ec3f3e41bf854db96ea3fb6ddf70c4ca1afb685feee",
    url = "https://github.com/coder/coder/releases/download/v2.17.0/coder_2.17.0_linux_amd64.tar.gz",
)

# Bazelisk binary

http_file(
    name = "bazelisk",
    executable=True,
    sha256 = "0fe572d6550898756ac1fa7f71d0a0d39532cf4cd9f74564697af1a088d8e292",
    url = "https://github.com/bazelbuild/bazelisk/releases/download/v1.23.0/bazelisk-linux-amd64",
)

# Skylib

http_archive(
    name = "bazel_skylib",
    sha256 = "bc283cdfcd526a52c3201279cda4bc298652efa898b10b4db0837dc51652756f",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
    ],
)

# Python

http_archive(
    name = "rules_python",
    sha256 = "ca2671529884e3ecb5b79d6a5608c7373a82078c3553b1fa53206e6b9dddab34",
    strip_prefix = "rules_python-0.38.0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.38.0/rules_python-0.38.0.tar.gz",
)

load("@rules_python//python:repositories.bzl", "py_repositories", "python_register_toolchains")

py_repositories()

python_register_toolchains(
    name = "python3_10",
    python_version = "3.10",
)

# Files

http_archive(
    name = "rules_file",
    sha256 = "1a9c25cb2a0aa240838175f86e42ca48683a914270641f8eae17c27bc78e9299",
    strip_prefix = "rules_file-a79a1036c27eb545cc6e7e08d99de525544bac4f",
    url = "https://github.com/rivethealth/rules_file/archive/a79a1036c27eb545cc6e7e08d99de525544bac4f.zip",
)

load("@rules_file//rules:init.bzl", "file_init")

file_init()

load("@rules_file//rules:workspace.bzl", "file_repositories")

file_repositories()

# aspect bazel lib

http_archive(
    name = "aspect_bazel_lib",
    sha256 = "a272d79bb0ac6b6965aa199b1f84333413452e87f043b53eca7f347a23a478e8",
    strip_prefix = "bazel-lib-2.9.3",
    url = "https://github.com/bazel-contrib/bazel-lib/releases/download/v2.9.3/bazel-lib-v2.9.3.tar.gz",
)

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies", "aspect_bazel_lib_register_toolchains")

# Required bazel-lib dependencies

aspect_bazel_lib_dependencies()

# Register bazel-lib toolchains

aspect_bazel_lib_register_toolchains()

# rules_pkg

http_archive(
    name = "rules_pkg",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/1.0.1/rules_pkg-1.0.1.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/1.0.1/rules_pkg-1.0.1.tar.gz",
    ],
    sha256 = "d20c951960ed77cb7b341c2a59488534e494d5ad1d30c4818c736d57772a9fef",
)
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
rules_pkg_dependencies()

# rules_oci

http_archive(
    name = "rules_oci",
    sha256 = "acbf8f40e062f707f8754e914dcb0013803c6e5e3679d3e05b571a9f5c7e0b43",
    strip_prefix = "rules_oci-2.0.1",
    url = "https://github.com/bazel-contrib/rules_oci/releases/download/v2.0.1/rules_oci-v2.0.1.tar.gz",
)

load("@rules_oci//oci:dependencies.bzl", "rules_oci_dependencies")

rules_oci_dependencies()

load("@rules_oci//oci:repositories.bzl", "oci_register_toolchains")

oci_register_toolchains(name = "oci")

# You can pull your base images using oci_pull like this:
load("@rules_oci//oci:pull.bzl", "oci_pull")

oci_pull(
    name = "distroless_base",
    digest = "sha256:7a4bffcb07307d97aa731b50cb6ab22a68a8314426f4e4428335939b5b1943a5",
    image = "gcr.io/distroless/base",
    platforms = [
        "linux/amd64",
    ],
)

oci_pull(
    name = "actions_runner",
    digest = "sha256:53f84be4517e62201d8d839b5dba3b715c5bbc99f51972725bcf042013d7e6de",
    image = "ghcr.io/actions/actions-runner",
    platforms = [
        "linux/amd64",
    ],
)

# rules_distroless

http_archive(
    name = "rules_distroless",
    sha256 = "6d1d739617e48fc3579781e694d3fabb08fc6c9300510982c01882732c775b8e",
    strip_prefix = "rules_distroless-0.3.8",
    url = "https://github.com/GoogleContainerTools/rules_distroless/releases/download/v0.3.8/rules_distroless-v0.3.8.tar.gz",
)

load("@rules_distroless//distroless:dependencies.bzl", "distroless_dependencies")

distroless_dependencies()

load("@rules_distroless//distroless:toolchains.bzl", "distroless_register_toolchains")

distroless_register_toolchains()

load("@rules_distroless//apt:index.bzl", "deb_index")

deb_index(
    name = "ubuntu_jammy",
    # For the initial setup, the lockfile attribute can be omitted and generated by running
    #    bazel run @ubuntu_jammy//:lock
    # This will generate the lock.json file next to the manifest file by replacing `.yaml` with `.lock.json`
    lock = "//images/actions-runner:apt.lock.json",
    manifest = "//images/actions-runner:apt.yaml",
)

load("@ubuntu_jammy//:packages.bzl", "ubuntu_jammy_packages")
ubuntu_jammy_packages()
