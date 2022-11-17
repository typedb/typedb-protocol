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
load("//grpc/rust/compile:compile.bzl", "rust_tonic_compile")

rust_tonic_compile(
    name = "typedb_protocol_src",
    packages = ["typedb.protocol"],
    srcs = [
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

rust_library(
    name = "typedb_protocol",
    srcs = [
        ":typedb_protocol_src",
        "lib.rs",
    ],
    deps = [
        "@vaticle_dependencies//library/crates:tonic",
        "@vaticle_dependencies//library/crates:prost",
    ],
    tags = [
        "crate-name=typedb-protocol",
    ],
    version = "0.1.2",
    visibility = ["//visibility:public"],
)

assemble_crate(
    name = "assemble_crate",
    target = ":typedb_protocol",
    description = "TypeDB Protocol",
    homepage = "https://github.com/vaticle/typedb-protocol",
    license = "AGPL-3.0-or-later",
    repository = "https://github.com/vaticle/typedb-protocol",
)

deploy_crate(
    name = "deploy_crate",
    target = ":assemble_crate",
    snapshot = deployment["crate.snapshot"],
    release = deployment["crate.release"]
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl-header",
    size = "small",
)
