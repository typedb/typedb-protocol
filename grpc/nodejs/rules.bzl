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
        #    Output services to the genrule output directory (without this line, typedb_grpc_pb is omitted)
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
#            "@npm//grpc_tools_node_protoc_ts",
#            "@npm//google-protobuf",
        ],
        srcs = [proto_sources_name]
    )
    unpack_proto_archive(
        name = name,
        deps = deps,
        grpc_deps = grpc_deps,
        archive = genrule_name,
    )