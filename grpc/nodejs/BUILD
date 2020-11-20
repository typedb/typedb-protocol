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

#load(":ts_grpc_compile.bzl", "ts_grpc_compile")

#ts_grpc_compile(
#    name = "protocol",
#    srcs = [
#        "//protobuf:raw-proto",
#    ],
#)

#ts_grpc_compile(
#    name = "protocol",
#    srcs = [
#        "//protobuf:answer-proto",
#        "//protobuf:concept-proto",
#        "//protobuf:database-proto",
#        "//protobuf:grakn-proto",
#        "//protobuf:options-proto",
#        "//protobuf:query-proto",
#        "//protobuf:session-proto",
#        "//protobuf:transaction-proto",
#    ],
#)

genrule(
    name = "protocol",
    outs = [
        "$(@D)/answer_pb.d.ts",
        "$(@D)/answer_pb.js",
        "$(@D)/concept_pb.d.ts",
        "$(@D)/concept_pb.js",
        "$(@D)/database_pb.d.ts",
        "$(@D)/database_pb.js",
        "$(@D)/grakn_pb.d.ts",
        "$(@D)/grakn_pb.js",
        "$(@D)/options_pb.d.ts",
        "$(@D)/options_pb.js",
        "$(@D)/query_pb.d.ts",
        "$(@D)/query_pb.js",
        "$(@D)/session_pb.d.ts",
        "$(@D)/session_pb.js",
        "$(@D)/transaction_pb.d.ts",
        "$(@D)/transaction_pb.js",
    ],
    cmd = "$(location @npm//grpc-tools/bin:grpc_tools_node_protoc) \
        --plugin=\'protoc-gen-ts=$(location @npm//grpc_tools_node_protoc_ts/bin:protoc-gen-ts)\' \
        --js_out=\'import_style=es6,binary:$(@D)/\' \
        --ts_out=\'binary:$(@D)/\' \
        --proto_path=. \
        $(locations //protobuf:proto-raw-buffers)",
    tools = ["@npm//grpc_tools_node_protoc_ts/bin:protoc-gen-ts", "@npm//grpc-tools/bin:grpc_tools_node_protoc", "//protobuf:proto-raw-buffers"],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl",
    size = "small",
)
