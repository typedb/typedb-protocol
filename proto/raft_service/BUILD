# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

package(default_visibility = ["//visibility:public"])

load("@typedb_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")

proto_library(
    name = "raft-service",
    srcs = ["raft_service.proto"],
    deps = [
        ":replication-proto",
        ":request-proto",
    ],
)

proto_library(
    name = "replication-proto",
    srcs = ["replication.proto"],
    deps = [],
)

proto_library(
    name = "request-proto",
    srcs = ["request.proto"],
    deps = [],
)

checkstyle_test(
    name = "checkstyle",
    size = "small",
    include = glob(["*"]),
    license_type = "mpl-header",
)
