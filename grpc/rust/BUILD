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
load("@rules_rust//cargo:cargo_build_script.bzl", "cargo_build_script")
load("@vaticle_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")

cargo_build_script(
    name = "typedb_protocol_src",
    srcs = ["build.rs"],
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
        "@com_google_protobuf//:protoc",
    ],
    build_script_env = {
        "PROTOC": "$(execpath @com_google_protobuf//:protoc)"
    },
    deps = [
        "@vaticle_dependencies//library/crates:tonic_build"
    ],
)

rust_library(
    name = "typedb_protocol",
    crate_name = "typedb-protocol",
    srcs = ["lib.rs"],
    deps = [
        ":typedb_protocol_src",
        "@vaticle_dependencies//library/crates:tonic",
        "@vaticle_dependencies//library/crates:prost",
    ],
    tags = [
        "crate-name=typedb-protocol",
    ],
    visibility = ["//visibility:public"],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl-header",
    size = "small",
)
