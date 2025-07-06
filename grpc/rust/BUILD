# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

load("@rules_rust//rust:defs.bzl", "rust_library")
load("@typedb_bazel_distribution//crates:rules.bzl", "assemble_crate", "deploy_crate")
load("@typedb_dependencies//distribution:deployment.bzl", "deployment")
load("@typedb_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@typedb_dependencies//builder/proto_grpc/rust:compile.bzl", "rust_tonic_compile")

rust_tonic_compile(
    name = "typedb_protocol_src",
    srcs = [
        "//proto:answer-proto",
        "//proto:authentication-proto",
        "//proto:concept-proto",
        "//proto:connection-proto",
        "//proto:database-proto",
        "//proto:error-proto",
        "//proto:migration-proto",
        "//proto:options-proto",
        "//proto:query-proto",
        "//proto:raft-peering-service",
        "//proto:server-proto",
        "//proto:transaction-proto",
        "//proto:typedb-service",
        "//proto:user-proto",
        "//proto:version-proto",
    ],
    packages = ["typedb.protocol"],
)

rust_library(
    name = "typedb_protocol",
    srcs = [
        ":typedb_protocol_src",
    ],
    crate_root = ":typedb_protocol_src",
    tags = [
        "crate-name=typedb-protocol",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@crates//:prost",
        "@crates//:tonic",
    ],
)

assemble_crate(
    name = "assemble_crate",
    description = "TypeDB Protocol",
    homepage = "https://github.com/typedb/typedb-protocol",
    license = "MPL-2.0",
    license_file = "//:LICENSE",
    readme_file = "//:README.md",
    repository = "https://github.com/typedb/typedb-protocol",
    target = ":typedb_protocol",
)

deploy_crate(
    name = "deploy_crate",
    release = deployment["crate"]["release"],
    snapshot = deployment["crate"]["snapshot"],
    target = ":assemble_crate",
)

checkstyle_test(
    name = "checkstyle",
    size = "small",
    include = glob(["*"]),
    license_type = "mpl-header",
)
