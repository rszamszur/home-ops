workspace(name = "home-ops")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

# Age binary

http_archive(
    name = "age",
    build_file = "@home-ops//bazel/third_party:age.bazel",
    sha256 = "7df45a6cc87d4da11cc03a539a7470c15b1041ab2b396af088fe9990f7c79d50",
    url = "https://github.com/FiloSottile/age/releases/download/v1.2.1/age-v1.2.1-linux-amd64.tar.gz",
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
    sha256 = "414210b9a9541dbd18522d8973237566639fe143bac13deb039ded973aba58a2",
    url = "https://github.com/coder/coder/releases/download/v2.20.2/coder_2.20.2_linux_amd64.tar.gz",
)

# Bazelisk binary

http_file(
    name = "bazelisk",
    executable=True,
    sha256 = "fd8fdff418a1758887520fa42da7e6ae39aefc788cf5e7f7bb8db6934d279fc4",
    url = "https://github.com/bazelbuild/bazelisk/releases/download/v1.25.0/bazelisk-linux-amd64",
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
    sha256 = "2ef40fdcd797e07f0b6abda446d1d84e2d9570d234fddf8fcd2aa262da852d1c",
    strip_prefix = "rules_python-1.2.0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/1.2.0/rules_python-1.2.0.tar.gz",
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
    sha256 = "9869dc0c3404784d53c61e465b7b455f237671895e6bde6975540bdc9d0740ca",
    strip_prefix = "rules_file-7bd1ebf65d4b8e3b8d90ce6e5741d45358866d90",
    url = "https://github.com/rivethealth/rules_file/archive/7bd1ebf65d4b8e3b8d90ce6e5741d45358866d90.zip",
)

load("@rules_file//rules:init.bzl", "file_init")

file_init()

load("@rules_file//rules:workspace.bzl", "file_repositories")

file_repositories()

# aspect bazel lib

http_archive(
    name = "aspect_bazel_lib",
    sha256 = "40ba9d0f62deac87195723f0f891a9803a7b720d7b89206981ca5570ef9df15b",
    strip_prefix = "bazel-lib-2.14.0",
    url = "https://github.com/bazel-contrib/bazel-lib/releases/download/v2.14.0/bazel-lib-v2.14.0.tar.gz",
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
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/1.1.0/rules_pkg-1.1.0.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/1.1.0/rules_pkg-1.1.0.tar.gz",
    ],
    sha256 = "b7215c636f22c1849f1c3142c72f4b954bb12bb8dcf3cbe229ae6e69cc6479db",
)
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
rules_pkg_dependencies()

# rules_oci

http_archive(
    name = "rules_oci",
    sha256 = "1e7759852e8cad966ca793412d292f1d4af5831940fb2cb573f1890ad1e9641e",
    strip_prefix = "rules_oci-2.2.3",
    url = "https://github.com/bazel-contrib/rules_oci/releases/download/v2.2.3/rules_oci-v2.2.3.tar.gz",
)

load("@rules_oci//oci:dependencies.bzl", "rules_oci_dependencies")

rules_oci_dependencies()

load("@rules_oci//oci:repositories.bzl", "oci_register_toolchains")

oci_register_toolchains(name = "oci")

# You can pull your base images using oci_pull like this:
load("@rules_oci//oci:pull.bzl", "oci_pull")

oci_pull(
    name = "distroless_base",
    digest = "sha256:125eb09bbd8e818da4f9eac0dfc373892ca75bec4630aa642d315ecf35c1afb7",
    image = "gcr.io/distroless/base",
    platforms = [
        "linux/amd64",
    ],
)

oci_pull(
    name = "actions_runner",
    digest = "sha256:c0f93607a231275b8da0e2a3cb87b771672346f7685795b39b0caa6efc8bab86",
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
