# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

package(default_visibility = ["//visibility:public"])

load("@typedb_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")

proto_library(
    name = "typedb-service",
    srcs = ["typedb_service.proto"],
    deps = [
        ":authentication-proto",
        ":connection-proto",
        ":database-proto",
        ":migration-proto",
        ":server-proto",
        ":transaction-proto",
        ":user-proto",
    ],
)

proto_library(
    name = "analyze-proto",
    srcs = ["analyze.proto"],
    deps = [
        ":analyzed-conjunction-proto",
        ":concept-proto",
        ":error-proto",
        ":options-proto",
    ],
)

proto_library(
    name = "analyzed-conjunction-proto",
    srcs = ["analyzed-conjunction.proto"],
    deps = [
        ":answer-proto",
        ":concept-proto",
    ],
)

proto_library(
    name = "answer-proto",
    srcs = ["answer.proto"],
    deps = [":concept-proto"],
)

proto_library(
    name = "authentication-proto",
    srcs = ["authentication.proto"],
)

proto_library(
    name = "concept-proto",
    srcs = ["concept.proto"],
)

proto_library(
    name = "connection-proto",
    srcs = ["connection.proto"],
    deps = [
        ":authentication-proto",
        ":database-proto",
        ":server-proto",
        "//proto:version-proto",
    ],
)

proto_library(
    name = "database-proto",
    srcs = ["database.proto"],
    deps = [
        ":migration-proto",
    ],
)

proto_library(
    name = "error-proto",
    srcs = ["error.proto"],
)

proto_library(
    name = "migration-proto",
    srcs = ["migration.proto"],
    deps = [":concept-proto"],
)

proto_library(
    name = "options-proto",
    srcs = ["options.proto"],
)

proto_library(
    name = "query-proto",
    srcs = ["query.proto"],
    deps = [
        ":analyze-proto",
        ":answer-proto",
        ":concept-proto",
        ":error-proto",
        ":options-proto",
    ],
)

proto_library(
    name = "server-proto",
    srcs = ["server.proto"],
)

proto_library(
    name = "transaction-proto",
    srcs = ["transaction.proto"],
    deps = [
        ":analyze-proto",
        ":answer-proto",
        ":concept-proto",
        ":error-proto",
        ":options-proto",
        ":query-proto",
    ],
)

proto_library(
    name = "user-proto",
    srcs = ["user.proto"],
)

checkstyle_test(
    name = "checkstyle",
    size = "small",
    include = glob(["*"]),
    license_type = "mpl-header",
)
