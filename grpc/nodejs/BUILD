#
# Copyright (C) 2020 Grakn Labs
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

package(default_visibility = ["//visibility:public"])
load("@graknlabs_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@stackb_rules_proto//node:node_grpc_compile.bzl", "node_grpc_compile")

genrule(
    name = "protocol",
    outs = [
        "protobuf/answer_pb.d.ts",
        "protobuf/answer_pb.js",
        "protobuf/concept_pb.d.ts",
        "protobuf/concept_pb.js",
        "protobuf/database_pb.d.ts",
        "protobuf/database_pb.js",
        "protobuf/grakn_pb.d.ts",
        "protobuf/grakn_pb.js",
        "protobuf/grakn_grpc_pb.js",
        "protobuf/grakn_grpc_pb.d.ts",
        "protobuf/options_pb.d.ts",
        "protobuf/options_pb.js",
        "protobuf/query_pb.d.ts",
        "protobuf/query_pb.js",
        "protobuf/session_pb.d.ts",
        "protobuf/session_pb.js",
        "protobuf/transaction_pb.d.ts",
        "protobuf/transaction_pb.js",
    ],
    cmd = "ln -s $(execpath @npm//grpc_tools_node_protoc_ts/bin:protoc-gen-ts).runfiles/npm/node_modules ./node_modules ;\
        $(execpath @npm//grpc-tools/bin:grpc_tools_node_protoc) \
            --plugin='protoc-gen-ts=$(rootpath @npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts)' \
            --js_out='import_style=es6,binary:./$(@D)/' \
            --grpc_out='./$(@D)/' \
            --ts_out='./$(@D)/' \
            --proto_path=`dirname $(execpath //:WORKSPACE)` \
            $(execpaths //protobuf:proto-raw-buffers);",
        tools = [
            "@npm//grpc-tools/bin:grpc_tools_node_protoc",
            "@npm//grpc_tools_node_protoc_ts/bin:protoc-gen-ts",
            "@npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts",
            "@npm//grpc_tools_node_protoc_ts",
            "@npm//google-protobuf",
            "//protobuf:proto-raw-buffers",
            "//:WORKSPACE"
        ],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl",
    size = "small",
)
