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
load("@bazel_skylib//lib:paths.bzl", "paths")
load("@rules_proto//proto:defs.bzl", "ProtoInfo")

def _proto_sources(ctx):
    inputs = []
    for dep in ctx.attr.deps:
        for src in dep[ProtoInfo].direct_sources:
            inputs.append(src)
    return DefaultInfo(files = depset(inputs))


def _unpack_proto_archive(ctx):
    outputs = []
    for dep in ctx.attr.deps:
        for src in dep[ProtoInfo].direct_sources:
            outputs.extend([
                ctx.actions.declare_file(
                    src.path.replace('.proto', '_pb.d.ts')
                ),
                ctx.actions.declare_file(
                    src.path.replace('.proto', '_pb.js')
                ),
            ])

    for dep in ctx.attr.grpc_deps:
        for src in dep[ProtoInfo].direct_sources:
            outputs.extend([
                ctx.actions.declare_file(
                    src.path.replace('.proto', '_grpc_pb.js')
                ),
                ctx.actions.declare_file(
                    src.path.replace('.proto', '_grpc_pb.d.ts')
                ),
            ])
    ctx.actions.run_shell(
        inputs = [ctx.file.archive],
        outputs = outputs,
        mnemonic='x',
        command = "mkdir -p {} && tar -xvf {} -C {}/{}".format(
            ctx.label.package, ctx.file.archive.path,
            ctx.var["BINDIR"], ctx.label.package
        )
    )
    return DefaultInfo(files = depset(outputs))


proto_sources = rule(
    attrs = {
        "deps": attr.label_list(
            providers = [ProtoInfo],
        )
    },
    implementation = _proto_sources
)

unpack_proto_archive = rule(
    attrs = {
        "deps": attr.label_list(
            providers = [ProtoInfo],
        ),
        "grpc_deps": attr.label_list(
             providers = [ProtoInfo],
         ),
        "archive": attr.label(
            allow_single_file = True
        ),
    },
    implementation = _unpack_proto_archive
)

def _as_path(path, is_windows_host):
    if is_windows_host:
        return path.replace("/", "\\")
    else:
        return path

def _get_outputs(target, ctx):
    outputs = []
    root = target[ProtoInfo].proto_source_root
    for source in target[ProtoInfo].direct_sources:
        # test.proto -> {designated output dir}/test.ts
        name = source.path.replace(source.extension, "ts")
        dest = root
        # if the dest is pwd then make sure that we do not strip subdirectories.
#        print("root")
#        print(root)
        if dest == ".":
            dest = source.dirname[len(ctx.label.package) + 1:]
            if not dest:
                dest = "."
        output = ctx.actions.declare_file("/".join([dest, name])) # preserve dir structure for now
#        output = ctx.actions.declare_file("common/options.ts")
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
        args.add(paths.join(ctx.bin_dir.path, paths.dirname(ctx.build_file_path)), format = "--ts_out=%s")

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
#
#        print("outputs")
#        print(outputs[0].dirname)
#        print(outputs[0].basename)

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
#            allow_single_file = True,
#            default = ("//grpc/nodejs:grpc_tools_node_protoc")
            default = "@com_google_protobuf//:protoc"
        ),
        "_protoc_gen_ts": attr.label(
            cfg = "exec",
            executable = True,
#            allow_single_file = True,
            default = ("@npm//protoc-gen-ts/bin:protoc-gen-ts")
        )
   }
)


#def ts_grpc_compile(
#        name,
#        deps,
#        grpc_deps):
#    proto_sources_name = "{}__do_not_reference_1".format(name)
#    genrule_name = "{}__do_not_reference_2".format(name)
#    proto_sources(
#        name = proto_sources_name,
#        deps = deps
#    )
#    native.genrule(
#        name = genrule_name,
#        outs = [
#            "{}.tar.gz".format(genrule_name),
#        ],
#        # The below command performs a protoc compilation of our proto files into typescript and javascript. Line by line:
#        # Run the node.js protoc (protocol compiler) with the following flags:
#        #    Use the gen-ts plugin to generate typescript declaration files in addition to javascript
#        #    Output javascript with commonjs style exports, to the genrule output directory.
#        #    Output services to the genrule output directory (without this line, typedb_grpc_pb is omitted)
#        #    Output typescript to (you guessed it) the genrule output directory
#        #    Set the .proto file relative path to root folder (same as where WORKSPACE resides)
#        #    Use the .proto files found in the :proto-raw-buffers filegroup as inputs.
##                --plugin='protoc-gen-ts=$(rootpath @npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts)' \
#        cmd = "$(execpath //grpc/nodejs:grpc_tools_node_protoc) \
#                --plugin='protoc-gen-ts=$(execpath //grpc/nodejs:protoc-gen-ts)' \
#                --js_out='import_style=commonjs,binary:./$(@D)/' \
#                --grpc_out='grpc_js:./$(@D)/' \
#                --ts_out='grpc_js:./$(@D)/' \
#                --proto_path=. \
#                $(execpaths :{}) && tar cvf $@ -C ./$(@D)/ .".format(proto_sources_name),
#        tools = [
#            "//grpc/nodejs:grpc_tools_node_protoc",
##            "@npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts",
#            "//grpc/nodejs:protoc-gen-ts",
##            "@npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts",
##            "@npm//protoc-gen-ts/bin:protoc-gen-ts"
##            "@npm//grpc_tools_node_protoc_ts",
##            "@npm//google-protobuf",
#        ],
#        srcs = [proto_sources_name]
#    )
#    unpack_proto_archive(
#        name = name,
#        deps = deps,
#        grpc_deps = grpc_deps,
#        archive = genrule_name,
#    )