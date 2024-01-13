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

load("@rules_rust//rust:defs.bzl", "rust_library")
load("@vaticle_bazel_distribution//crates:rules.bzl", "assemble_crate", "deploy_crate")
load("@vaticle_dependencies//distribution:deployment.bzl", "deployment")
load("@vaticle_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@vaticle_dependencies//builder/proto_grpc/rust:compile.bzl", "rust_tonic_compile")

rust_tonic_compile(
    name = "typedb_protocol_src",
    packages = ["typedb.protocol"],
    srcs = [
        "//proto:typedb-service",
        "//proto:server-proto",
        "//proto:user-proto",
        "//proto:database-proto",
        "//proto:answer-proto",
        "//proto:concept-proto",
        "//proto:connection-proto",
        "//proto:logic-proto",
        "//proto:options-proto",
        "//proto:query-proto",
        "//proto:session-proto",
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
    homepage = "https://github.com/vaticle/typedb-protocol",
    readme_file = "//:README.md",
    license = "AGPL-3.0-or-later",
    license_file = "//:LICENSE",
    repository = "https://github.com/vaticle/typedb-protocol",
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
    license_type = "agpl-header",
    size = "small",
)
