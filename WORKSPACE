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
    sha256 = "26bd2fbf489bf053e6e10882957c89f1e5b217ed1b75c9f504798e6f905e18aa",
    url = "https://github.com/coder/coder/releases/download/v2.22.1/coder_2.22.1_linux_amd64.tar.gz",
)

# Bazelisk binary

http_file(
    name = "bazelisk",
    executable=True,
    sha256 = "6539c12842ad76966f3d493e8f80d67caa84ec4a000e220d5459833c967c12bc",
    url = "https://github.com/bazelbuild/bazelisk/releases/download/v1.26.0/bazelisk-linux-amd64",
)

# GitHub Actions runner

http_archive(
    name = "runner",
    build_file = "@home-ops//bazel/third_party:runner.bazel",
    sha256 = "e8e24a3477da17040b4d6fa6d34c6ecb9a2879e800aa532518ec21e49e21d7b4",
    url = "https://github.com/actions/runner/releases/download/v2.324.0/actions-runner-linux-x64-2.324.0.tar.gz",
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
    sha256 = "9f9f3b300a9264e4c77999312ce663be5dee9a56e361a1f6fe7ec60e1beef9a3",
    strip_prefix = "rules_python-1.4.1",
    url = "https://github.com/bazelbuild/rules_python/releases/download/1.4.1/rules_python-1.4.1.tar.gz",
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
    sha256 = "fc8fe1be58ae39f84a8613d554534760c7f0819d407afcc98bbcbd990523bfed",
    strip_prefix = "bazel-lib-2.16.0",
    url = "https://github.com/bazel-contrib/bazel-lib/releases/download/v2.16.0/bazel-lib-v2.16.0.tar.gz",
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
    sha256 = "5994ec0e8df92c319ef5da5e1f9b514628ceb8fc5824b4234f2fe635abb8cc2e",
    strip_prefix = "rules_oci-2.2.6",
    url = "https://github.com/bazel-contrib/rules_oci/releases/download/v2.2.6/rules_oci-v2.2.6.tar.gz",
)

load("@rules_oci//oci:dependencies.bzl", "rules_oci_dependencies")

rules_oci_dependencies()

load("@rules_oci//oci:repositories.bzl", "oci_register_toolchains")

oci_register_toolchains(name = "oci")

# You can pull your base images using oci_pull like this:
load("@rules_oci//oci:pull.bzl", "oci_pull")

oci_pull(
    name = "distroless_base",
    digest = "sha256:27769871031f67460f1545a52dfacead6d18a9f197db77110cfc649ca2a91f44",
    image = "gcr.io/distroless/base",
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
