# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

load("@bazel_skylib//lib:paths.bzl", "paths")
load("@rules_proto//proto:defs.bzl", "ProtoInfo")

def _as_path(path, is_windows_host):
    if is_windows_host:
        return path.replace("/", "\\")
    else:
        return path

def _get_outputs(target, ctx):
    outputs = []
    root = target[ProtoInfo].proto_source_root
    for source in target[ProtoInfo].direct_sources:
        name = source.path
        # test.proto -> {designated output dir}/test.ts
        if name.endswith("." + source.extension):
            name = name.rsplit(".", 1)[0]
        name += ".ts"

        dest = root
        # if the dest is pwd then make sure that we do not strip subdirectories.
        if dest == ".":
            dest = source.dirname[len(ctx.label.package) + 1:]
            if not dest:
                dest = "."

        if dest != ".":
            if name.startswith(dest):
                name = name[len(dest)+1:]

        output = ctx.actions.declare_file(name) # preserve dir structure for now
        outputs.append(output)
    return outputs

def _imported_protos(target, provided_sources = []):
    proto_info = target[ProtoInfo]
    source_root = proto_info.proto_source_root
    if source_root == ".":
        return [src.path for src in proto_info.direct_sources]
    offset = len(source_root) + 1  # + '/'.
    return [src.path[offset:] for src in proto_info.direct_sources]

def _node_protoc(ctx):
    all_outputs = []
    is_windows_host = ctx.configuration.host_path_separator == ";"
    for target in ctx.attr.deps:
        args = ctx.actions.args()
        # Output and Plugin path
        args.add(_as_path(ctx.executable._protoc_gen_ts.path, is_windows_host), format = "--plugin=protoc-gen-ts=%s")
        args.add(paths.join(ctx.bin_dir.path, paths.dirname(ctx.file._file_in_project.path)), format = "--ts_out=%s")
        args.add("--ts_opt=no_namespace")

        # Set in descriptors
        descriptor_sets_paths = [desc.path for desc in target[ProtoInfo].transitive_descriptor_sets.to_list()]
        args.add_joined("--descriptor_set_in", descriptor_sets_paths, join_with = ctx.configuration.host_path_separator)

        # Direct sources
        args.add_all(_imported_protos(target))

        if not len(ctx.outputs.outs):
            outputs = _get_outputs(target, ctx)
            all_outputs.extend(outputs)
        else:
            outputs = ctx.outputs.outs
            all_outputs = ctx.outputs.outs

        ctx.actions.run(
            inputs = depset(target[ProtoInfo].direct_sources, transitive = [target[ProtoInfo].transitive_descriptor_sets]),
            tools = [ctx.executable._protoc_gen_ts],
            executable = ctx.executable._protoc,
            outputs = outputs,
            arguments = [args],
            progress_message = "Generating Protocol Buffers for Typescript %s" % ctx.label,
            env = {"BAZEL_BINDIR": ctx.bin_dir.path},
        )

    return [
        DefaultInfo(files = depset(all_outputs))
    ]


ts_grpc_compile = rule(
    implementation = _node_protoc,
    attrs = {
        "deps": attr.label_list(
            doc = "List of proto_library targets.",
            providers = [ProtoInfo],
            mandatory = True
        ),
        "outs": attr.output_list(),
        "_protoc": attr.label(
            cfg = "exec",
            executable = True,
            default = "@com_google_protobuf//:protoc"
        ),
        "_protoc_gen_ts": attr.label(
            cfg = "exec",
            executable = True,
            default = "@typedb_protocol//grpc/nodejs:protoc-gen-ts",
        ),
        "_file_in_project": attr.label(
            default = "@typedb_protocol//grpc/nodejs:BUILD",
            allow_single_file = True,
        ),
   }
)
