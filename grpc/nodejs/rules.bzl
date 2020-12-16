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
    ctx.actions.run(
        inputs = [ctx.file.archive],
        outputs = outputs,
        executable = ctx.executable._unpack_proto_archive,
        arguments = [ctx.file.archive.path] + [x.path for x in outputs]
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
        "_unpack_proto_archive": attr.label(
            executable = True,
            cfg = "host",
            default = "//grpc/nodejs:unpack_proto_archive",
        )
    },
    implementation = _unpack_proto_archive
)


def ts_grpc_compile(
        name,
        deps,
        grpc_deps):
    proto_sources_name = "{}__do_not_reference_1".format(name)
    genrule_name = "{}__do_not_reference_2".format(name)
    proto_sources(
        name = proto_sources_name,
        deps = deps
    )
    native.genrule(
        name = genrule_name,
        outs = [
            "{}.tar.gz".format(genrule_name),
        ],
        # The below command performs a protoc compilation of our proto files into typescript and javascript. Line by line:
        # Run the node.js protoc (protocol compiler) with the following flags:
        #    Use the gen-ts plugin to generate typescript declaration files in addition to javascript
        #    Output javascript with commonjs style exports, to the genrule output directory.
        #    Output services to the genrule output directory (without this line, grakn_grpc_pb is omitted)
        #    Output typescript to (you guessed it) the genrule output directory
        #    Set the .proto file relative path to root folder (same as where WORKSPACE resides)
        #    Use the .proto files found in the :proto-raw-buffers filegroup as inputs.
        cmd = "$(execpath //grpc/nodejs:grpc_tools_node_protoc) \
                --plugin='protoc-gen-ts=$(rootpath @npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts)' \
                --js_out='import_style=commonjs,binary:./$(@D)/' \
                --grpc_out='grpc_js:./$(@D)/' \
                --ts_out='grpc_js:./$(@D)/' \
                --proto_path=. \
                $(execpaths :{}) && tar cvf $@ -C ./$(@D)/ .".format(proto_sources_name),
        tools = [
            "//grpc/nodejs:grpc_tools_node_protoc",
            "@npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts",
            "@npm//grpc_tools_node_protoc_ts",
            "@npm//google-protobuf",
        ],
        srcs = [proto_sources_name]
    )
    unpack_proto_archive(
        name = name,
        deps = deps,
        grpc_deps = grpc_deps,
        archive = genrule_name,
    )