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
    packages = ["typedb.protocol"],
    srcs = [
        "//proto:typedb-service",
        "//proto:server-proto",
        "//proto:user-proto",
        "//proto:database-proto",
        "//proto:migration-proto",
        "//proto:error-proto",
        "//proto:answer-proto",
        "//proto:concept-proto",
        "//proto:connection-proto",
        "//proto:authentication-proto",
        "//proto:options-proto",
        "//proto:query-proto",
        "//proto:structure-proto",
        "//proto:transaction-proto",
        "//proto:version-proto",
    ]
)

rust_library(
    name = "typedb_protocol",
    crate_root = ":typedb_protocol_src",
    srcs = [
        ":typedb_protocol_src",
    ],
    deps = [
        "@crates//:tonic",
        "@crates//:prost",
    ],
    tags = [
        "crate-name=typedb-protocol",
    ],
    visibility = ["//visibility:public"],
)

assemble_crate(
    name = "assemble_crate",
    target = ":typedb_protocol",
    description = "TypeDB Protocol",
    homepage = "https://github.com/typedb/typedb-protocol",
    readme_file = "//:README.md",
    license = "MPL-2.0",
    license_file = "//:LICENSE",
    repository = "https://github.com/typedb/typedb-protocol",
)

deploy_crate(
    name = "deploy_crate",
    target = ":assemble_crate",
    snapshot = deployment["crate"]["snapshot"],
    release = deployment["crate"]["release"]
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "mpl-header",
    size = "small",
)
