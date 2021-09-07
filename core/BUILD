#
# Copyright (C) 2021 Vaticle
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

proto_library(
    name = "database-proto",
    srcs = ["core_database.proto"],
)

proto_library(
    name = "service-proto",
    srcs = ["core_service.proto"],
    deps = [
        "//core:database-proto",
        "//common:client-proto",
        "//common:session-proto",
        "//common:transaction-proto",
    ],
)

# TODO: This should eventually be removed
# At the moment, this exists to support Node.js libraries.
# When it becomes a real rule, we should extract the .src_files from the above proto_library rules.
# For now, this is required to get the source files.
filegroup(
    name = "proto-raw-buffers",
    srcs = [
        "core_database.proto",
        "core_service.proto",
    ]
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl",
    size = "small",
)
