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

package(default_visibility = ["//visibility:public"])
load("@vaticle_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@rules_proto_grpc//java:defs.bzl", "java_grpc_library")

java_grpc_library(
    name = "typedb-protocol",
    protos = [
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
    ],
    # TypeDB Core bundles JARs by maven coordinate, we can remove this when Core is rewritten in Rust
    tags = ["maven_coordinates=com.vaticle.typedb:typedb-protocol:{pom_version}"],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl-header",
    size = "small",
)
