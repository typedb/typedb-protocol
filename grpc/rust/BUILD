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

load("@rules_rust//proto:proto.bzl", "rust_grpc_library")
load("@rules_rust//proto:toolchain.bzl", "rust_proto_toolchain")
load("@rules_rust//rust:defs.bzl", "rust_binary")

# TODO: once we clarify how we should compile the gRPC + Protobuf library, delete this target
rust_binary(
    name = "proto_compile",
    srcs = ["main.rs"],
    data = [
        "//cluster:service-proto",
        "//cluster:server-proto",
        "//cluster:user-proto",
        "//cluster:database-proto",
        "//common:answer-proto",
        "//common:concept-proto",
        "//common:logic-proto",
        "//common:options-proto",
        "//common:query-proto",
        "//common:session-proto",
        "//common:transaction-proto",
        "//core:database-proto",
        "//core:service-proto",
    ],
    deps = [
        "@vaticle_dependencies//library/crates:protoc_rust_grpc",
    ],
)

rust_proto_toolchain(
    name = "proto_toolchain_impl",
    # Path to the protobuf compiler.
    protoc = "@com_google_protobuf//:protoc",
    # Protobuf compiler plugin to generate rust gRPC stubs.
    grpc_plugin = "@vaticle_dependencies//library/crates:cargo_bin_protoc_gen_rust_grpc",
    # Protobuf compiler plugin to generate rust protobuf stubs.
    proto_plugin = "@vaticle_dependencies//library/crates:cargo_bin_protoc_gen_rust",
)

toolchain(
    name = "proto_toolchain",
    toolchain = ":proto_toolchain_impl",
    toolchain_type = "@rules_rust//proto:toolchain_type",
)

rust_grpc_library(
    name = "typedb_protocol_src",
    deps = [
        "//cluster:service-proto",
        "//cluster:server-proto",
        "//cluster:user-proto",
        "//cluster:database-proto",
        "//common:answer-proto",
        "//common:concept-proto",
        "//common:logic-proto",
        "//common:options-proto",
        "//common:query-proto",
        "//common:session-proto",
        "//common:transaction-proto",
        "//core:database-proto",
        "//core:service-proto",
    ]
)

# TODO: add assemble_crate and deploy_crate targets

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl-header",
    size = "small",
)
