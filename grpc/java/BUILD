# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

package(default_visibility = ["//visibility:public"])

load("@typedb_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@rules_proto_grpc//java:defs.bzl", "java_grpc_library")

java_grpc_library(
    name = "typedb-protocol",
    protos = [
        "//proto:analyze-proto",
        "//proto:analyzed-conjunction-proto",
        "//proto:answer-proto",
        "//proto:authentication-proto",
        "//proto:concept-proto",
        "//proto:connection-proto",
        "//proto:database-proto",
        "//proto:error-proto",
        "//proto:migration-proto",
        "//proto:options-proto",
        "//proto:query-proto",
        "//proto:server-proto",
        "//proto:transaction-proto",
        "//proto:typedb-service",
        "//proto:user-proto",
        "//proto:version-proto",
    ],
    # TypeDB Core bundles JARs by maven coordinate, we can remove this when Core is rewritten in Rust
    tags = ["maven_coordinates=com.typedb:typedb-protocol:{pom_version}"],
)

checkstyle_test(
    name = "checkstyle",
    size = "small",
    include = glob(["*"]),
    license_type = "mpl-header",
)
