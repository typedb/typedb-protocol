# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

package(default_visibility = ["//visibility:public"])
load("@typedb_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@rules_proto_grpc//java:defs.bzl", "java_grpc_library")

java_grpc_library(
    name = "typedb-protocol",
    protos = [
        "//proto:version-proto",
        "//proto/raft_service:raft-service",
        "//proto/raft_service:replication-proto",
        "//proto/typedb_clustering_service:typedb-clustering-service",
        "//proto/typedb_clustering_service:typedb-clustering-proto",
        "//proto/typedb_service:analyze-proto",
        "//proto/typedb_service:analyzed-conjunction-proto",
        "//proto/typedb_service:answer-proto",
        "//proto/typedb_service:authentication-proto",
        "//proto/typedb_service:concept-proto",
        "//proto/typedb_service:connection-proto",
        "//proto/typedb_service:database-proto",
        "//proto/typedb_service:error-proto",
        "//proto/typedb_service:migration-proto",
        "//proto/typedb_service:options-proto",
        "//proto/typedb_service:query-proto",
        "//proto/typedb_service:server-proto",
        "//proto/typedb_service:transaction-proto",
        "//proto/typedb_service:typedb-service",
        "//proto/typedb_service:user-proto",
    ],
    # TypeDB Core bundles JARs by maven coordinate, we can remove this when Core is rewritten in Rust
    tags = ["maven_coordinates=com.typedb:typedb-protocol:{pom_version}"],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "mpl-header",
    size = "small",
)
