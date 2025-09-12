# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

package(default_visibility = ["//visibility:public"])

load("@typedb_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")

proto_library(
    name = "typedb-service",
    srcs = [":typedb-service.proto"],
    deps = [
        ":connection-proto",
        ":authentication-proto",
        ":server-proto",
        ":user-proto",
        ":database-proto",
        ":transaction-proto",
        ":migration-proto",
    ],
)

proto_library(
    name = "server-proto",
    srcs = [":server.proto"],
)

proto_library(
    name = "database-proto",
    srcs = [":database.proto"],
    deps = [
        ":migration-proto",
    ],
)

proto_library(
    name = "migration-proto",
    srcs = [":migration.proto"],
    deps = [":concept-proto"],
)

proto_library(
    name = "user-proto",
    srcs = [":user.proto"],
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
        ":version-proto"
    ],
)

proto_library(
    name = "options-proto",
    srcs = ["options.proto"],
)

proto_library(
    name = "query-proto",
    srcs = ["query.proto"],
    deps = [
        ":answer-proto",
        ":concept-proto",
        ":error-proto",
        ":options-proto",
    ],
)

proto_library(
    name = "error-proto",
    srcs = ["error.proto"],
)

proto_library(
    name = "transaction-proto",
    srcs = ["transaction.proto"],
    deps = [
        ":answer-proto",
        ":concept-proto",
        ":error-proto",
        ":options-proto",
        ":query-proto",
    ]
)

proto_library(
    name = "analyze-proto",
    srcs = ["analyze.proto"],
    deps = [
        ":conjunction-proto",
    ],
)

proto_library(
    name = "conjunction-proto",
    srcs = ["conjunction.proto"],
    deps = [
        ":answer-proto",
        ":concept-proto",
    ],
)

proto_library(
    name = "version-proto",
    srcs = ["version.proto"],
)

# TODO: THIS SHOULD BE MADE TO STOP EXISTING
# This exists to support the nodejs build- when it becomes a real rule, we should extract the .src_files
# from the above proto_library rules, but for now this is required to get the source files.
filegroup(
    name = "proto-raw-buffers",
    srcs = [
        "answer.proto",
        "concept.proto",
        "connection.proto",
        "options.proto",
        "query.proto",
        "transaction.proto",
        "version.proto",
    ]
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "mpl-header",
    size = "small",
)
