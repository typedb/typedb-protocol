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

proto_library(
    name = "service-proto",
    srcs = [":service.proto"],
    deps = [
        ":server-proto",
        ":user-proto",
        ":database-proto",
        "//common:session-proto",
        "//common:transaction-proto",
    ],
)

proto_library(
    name = "server-proto",
    srcs = [":server.proto"],
)

proto_library(
    name = "user-proto",
    srcs = [":user.proto"],
)

proto_library(
    name = "database-proto",
    srcs = [":database.proto"],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl-header",
    size = "small",
)
