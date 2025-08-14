# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

package(default_visibility = ["//visibility:public"])

load("@typedb_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")

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
<<<<<<< HEAD
        "//proto/typedb_service:analyze.proto",
        "//proto/typedb_service:analyzed-conjunction.proto",
=======
>>>>>>> 55ed142 (Split protocol into 3 separate services (#230))
        "//proto/typedb_service:answer.proto",
        "//proto/typedb_service:concept.proto",
        "//proto/typedb_service:connection.proto",
        "//proto/typedb_service:options.proto",
        "//proto/typedb_service:query.proto",
        "//proto/typedb_service:transaction.proto",
        "version.proto",
    ],
)

checkstyle_test(
    name = "checkstyle",
    size = "small",
    include = glob(["*"]),
    license_type = "mpl-header",
)
