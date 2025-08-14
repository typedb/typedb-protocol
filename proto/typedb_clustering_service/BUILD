# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

package(default_visibility = ["//visibility:public"])

load("@typedb_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")

proto_library(
    name = "typedb-clustering-service",
    srcs = ["typedb_clustering_service.proto"],
    deps = [
        ":typedb-clustering-proto",
    ],
)

proto_library(
    name = "typedb-clustering-proto",
    srcs = ["typedb_clustering.proto"],
    deps = [
        "//proto/typedb_service:server-proto",
    ],
)

checkstyle_test(
    name = "checkstyle",
    size = "small",
    include = glob(["*"]),
    license_type = "mpl-header",
)
