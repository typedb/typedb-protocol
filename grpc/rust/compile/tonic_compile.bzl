#
# Copyright (C) 2022 Vaticle
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

def _rust_tonic_compile_impl(ctx):
    inputs = ctx.attr.protoc.files.to_list()
    proto_paths_str = ""
    for src in ctx.attr.srcs:
        inputs.append(src[ProtoInfo].direct_sources[0])
        proto_paths_str = proto_paths_str + src[ProtoInfo].direct_sources[0].path + ";"

    outputs = []
    for package in ctx.attr.packages:
        outputs.append(ctx.actions.declare_file("{}.rs".format(package)))

    ctx.actions.run(
        inputs = inputs,
        outputs = outputs,
        executable = ctx.executable._compile_script,
        env = {
            "OUT_DIR": outputs[0].dirname,
            "PROTOC": ctx.attr.protoc.files.to_list()[0].path,
            "PROTOS": proto_paths_str,
            "PROTOS_ROOT": ctx.attr.srcs[0][ProtoInfo].proto_source_root,
        },
        mnemonic = "RustTonicCompileAction"
    )

    return [DefaultInfo(files = depset(outputs))]

rust_tonic_compile = rule(
    implementation = _rust_tonic_compile_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            mandatory = True,
            doc = "The .proto source files."
        ),
        "packages": attr.string_list(
            mandatory = True,
            allow_empty = False,
            doc = "The Protobuf package names. Each package name corresponds to a single output file."
        ),
        "deps": attr.label_list(
            default = ["@vaticle_dependencies//library/crates:tonic_build"]
        ),
        "protoc": attr.label(
            default = "@com_google_protobuf//:protoc",
            doc = "The protoc executable."
        ),
        "_compile_script": attr.label(
            executable = True,
            cfg = "host",
            default = "//grpc/rust/compile:compile",
        ),
    }
)
