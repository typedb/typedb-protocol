#
# Copyright (C) 2021 Grakn Labs
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
load("@build_bazel_rules_nodejs//:index.bzl", "pkg_npm", "nodejs_binary")
load("@graknlabs_bazel_distribution//npm:rules.bzl", "assemble_npm", "deploy_npm")
load("@graknlabs_dependencies//distribution:deployment.bzl", "deployment")
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
    name = "protocol",
    deps = [
        "//protobuf:answer-proto",
        "//protobuf:concept-proto",
        "//protobuf:database-proto",
        "//protobuf:grakn-proto",
        "//protobuf:logic-proto",
        "//protobuf:options-proto",
        "//protobuf:query-proto",
        "//protobuf:session-proto",
        "//protobuf:transaction-proto",
    ],
    grpc_deps = [
        "//protobuf:grakn-proto",
    ]
)

ts_grpc_compile(
    name = "protocol-cluster",
    deps = [
        "//protobuf/cluster:cluster-proto",
        "//protobuf/cluster:database-proto",
        "//protobuf/cluster:grakn-cluster-proto",
    ],
    grpc_deps = [
        "//protobuf/cluster:grakn-cluster-proto",
    ]
)

pkg_npm(
    name = "protocol-package",
    package_name = "graknlabs_protocol",
    srcs = glob([
        "package.json",
    ]),
    deps = [
        ":protocol",
        ":protocol-cluster",
    ],
)

assemble_npm(
    name = "assemble-npm",
    target = ":protocol-package",
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
    exclude = ["package.json"],
    license_type = "agpl",
    size = "small",
)
