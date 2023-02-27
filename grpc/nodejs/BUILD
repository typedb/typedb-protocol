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
load("@build_bazel_rules_nodejs//:index.bzl", "pkg_npm", "nodejs_binary")
load("@vaticle_bazel_distribution//npm:rules.bzl", "assemble_npm", "deploy_npm")
load("@vaticle_dependencies//distribution:deployment.bzl", "deployment")
load("//:deployment.bzl", github_deployment = "deployment")
load("//grpc/nodejs:rules.bzl", "ts_grpc_compile")


nodejs_binary(
  name = "grpc_tools_node_protoc",
  data = ["@npm//grpc-tools:grpc-tools"],
  entry_point = "@npm//:node_modules/grpc-tools/bin/protoc.js",
  templated_args = ["--nobazel_node_patches"],
)

nodejs_binary(
  name = "protoc-gen-ts",
  data = ["@npm//grpc_tools_node_protoc_ts:grpc_tools_node_protoc_ts"],
  entry_point = "@npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts",
  templated_args = ["--nobazel_node_patches"],
)

ts_grpc_compile(
    name = "typedb-protocol-src",
    deps = [
        "//proto:server-proto",
        "//proto:user-proto",
        "//proto:database-proto",
        "//proto:service-proto", # TODO: do we need this?
        "//proto:answer-proto",
        "//proto:concept-proto",
        "//proto:logic-proto",
        "//proto:options-proto",
        "//proto:query-proto",
        "//proto:session-proto",
        "//proto:transaction-proto",
    ],
    grpc_deps = [
        "//proto:service-proto",
    ]
)

pkg_npm(
    name = "typedb-protocol",
    package_name = "typedb_protocol",
    srcs = ["package.json"],
    deps = [":typedb-protocol-src"],
)

assemble_npm(
    name = "assemble-npm",
    target = ":typedb-protocol",
)

deploy_npm(
    name = "deploy-npm",
    target = ":assemble-npm",
    snapshot = deployment["npm.snapshot"],
    release = deployment["npm.release"],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    exclude = [
        "package.json",
        "yarn.lock",
    ],
    license_type = "agpl-header",
    size = "small",
)
