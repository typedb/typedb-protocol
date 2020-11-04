#
# Copyright (C) 2020 Grakn Labs
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

load("@graknlabs_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")

proto_library(
    name = "answer-proto",
    srcs = ["answer.proto"],
    deps = [":concept-proto"],
)

proto_library(
    name = "concept-proto",
    srcs = ["concept.proto"],
)

proto_library(
    name = "database-proto",
    srcs = ["database.proto"],
)

proto_library(
    name = "grakn-proto",
    srcs = ["grakn.proto"],
    deps = [
        ":database-proto",
        ":session-proto",
        ":transaction-proto",
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
        ":options-proto",
    ],
)

proto_library(
    name = "session-proto",
    srcs = ["session.proto"],
    deps = [":options-proto"],
)

proto_library(
    name = "transaction-proto",
    srcs = ["transaction.proto"],
    deps = [
        ":answer-proto",
        ":concept-proto",
        ":options-proto",
        ":query-proto",
    ]
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl",
    size = "small",
)
