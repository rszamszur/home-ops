load("@bazel_skylib//lib:shell.bzl", "shell")
load("@rules_file//util:path.bzl", "runfile_path")
load("@rules_file//generate:providers.bzl", "FormatterInfo")

def _packer_build(ctx):
    actions = ctx.actions
    data = ctx.files.data
    label = ctx.label
    options = ctx.attr.options
    path = ctx.attr.path
    packer = ctx.file._packer
    name = ctx.attr.name
    runner = ctx.file._runner
    workspace = ctx.workspace_name

    if path.startswith("/"):
        path = path[1:]
    else:
        path = "/".join([part for part in [workspace, label.package, path] if part])

    executable = actions.declare_file(name)
    actions.expand_template(
        is_executable = True,
        output = executable,
        substitutions = {
            "%{options}": " ".join([shell.quote(option) for option in options]),
            "%{packer}": shell.quote(runfile_path(workspace, packer)),
            "%{path}": shell.quote(path),
        },
        template = runner,
    )

    runfiles = ctx.runfiles(files = [packer] + data)
    default_info = DefaultInfo(
        executable = executable,
        runfiles = runfiles,
    )

    return [default_info]

packer_build = rule(
    attrs = {
        "data": attr.label_list(allow_files = True),
        "options": attr.string_list(),
        "path": attr.string(),
        "_packer": attr.label(allow_single_file = True, default = "@packer//:packer"),
        "_runner": attr.label(allow_single_file = True, default = ":build-runner.sh.tpl"),
    },
    executable = True,
    implementation = _packer_build,
)

def _packer_init(ctx):
    actions = ctx.actions
    data = ctx.files.data
    label = ctx.label
    packer = ctx.file._packer
    path = ctx.attr.path
    name = ctx.attr.name
    runner = ctx.file._runner
    workspace = ctx.workspace_name

    if path.startswith("/"):
        path = path[1:]
    else:
        path = "/".join([part for part in [workspace, label.package, path] if part])

    executable = actions.declare_file(name)
    actions.expand_template(
        is_executable = True,
        output = executable,
        substitutions = {
            "%{packer}": shell.quote(runfile_path(workspace, packer)),
            "%{path}": shell.quote(path),
        },
        template = runner,
    )

    runfiles = ctx.runfiles(files = [packer] + data)
    default_info = DefaultInfo(
        executable = executable,
        runfiles = runfiles,
    )

    return [default_info]

packer_init = rule(
    attrs = {
        "data": attr.label_list(allow_files = True),
        "path": attr.string(),
        "_packer": attr.label(allow_single_file = True, default = "@packer//:packer"),
        "_runner": attr.label(allow_single_file = True, default = ":init-runner.sh.tpl"),
    },
    executable = True,
    implementation = _packer_init,
)

def _packer_format(ctx, src, out, bin):
    ctx.actions.run_shell(
        command = '< "$2" "$1" fmt - > "$3"',
        arguments = [bin.path, src.path, out.path],
        inputs = [bin, src],
        outputs = [out],
    )

def _packer_format_impl(ctx):
    packer = ctx.file._packer

    def format(ctx, path, src, out):
        _packer_format(ctx, src, out, packer)

    format_info = FormatterInfo(fn = format)

    return [format_info]

packer_format = rule(
    implementation = _packer_format_impl,
    attrs = {
        "_packer": attr.label(allow_single_file = True, default = "@packer//:packer"),
    },
)