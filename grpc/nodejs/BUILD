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
load("@vaticle_bazel_distribution//npm:rules.bzl", "assemble_npm", "deploy_npm")
load("@vaticle_dependencies//distribution:deployment.bzl", "deployment")
load("@aspect_rules_js//npm:defs.bzl", "npm_package")
load("@aspect_rules_ts//ts:defs.bzl", "ts_project")
load("@vaticle_typedb_protocol_npm//:defs.bzl", "npm_link_all_packages")
load("//:deployment.bzl", github_deployment = "deployment")
load("//grpc/nodejs:rules.bzl", "ts_grpc_compile")

npm_link_all_packages(name = "node_modules")

exports_files(["package.json", "pnpm-lock.yaml"])

load("@vaticle_typedb_protocol_npm//grpc/nodejs:protoc-gen-ts/package_json.bzl", protoc_gen_ts_bin = "bin")

protoc_gen_ts_bin.protoc_gen_ts_binary(
    name = "protoc-gen-ts",
)

ts_grpc_compile(
    name = "typedb-protocol-src",
    deps = [
        "//proto:server-proto",
        "//proto:user-proto",
        "//proto:database-proto",
        "//proto:answer-proto",
        "//proto:concept-proto",
        "//proto:connection-proto",
        "//proto:logic-proto",
        "//proto:options-proto",
        "//proto:query-proto",
        "//proto:session-proto",
        "//proto:transaction-proto",
        "//proto:version-proto",
        "//proto:service-proto",
    ]
)

ts_project(
    name = "typedb-protocol",
    srcs = [":typedb-protocol-src"],
    tsconfig = {
        "compilerOptions": {
            "target": "es2019",
            "module": "commonjs",
            "moduleResolution": "node",
            "esModuleInterop": True,
        },
        "include": [
            "proto",
        ]
    },
    declaration = True,
    deps = [
        ":node_modules/@grpc/grpc-js",
        ":node_modules/google-protobuf",
        ":node_modules/@types/google-protobuf",
        ":node_modules/@types/node",
        ":node_modules/typescript",
    ],
    visibility = ["//visibility:public"],
)

npm_package(
    name = "typedb-protocol-package",
    srcs = [":typedb-protocol", "package.json"],
    include_runfiles = False,
    package = "typedb-protocol",
    include_external_repositories = ["vaticle_typedb_protocol"],
    visibility = ["//visibility:public"],
)

assemble_npm(
    name = "assemble-npm",
    target = ":typedb-protocol-package",
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
        "pnpm-lock.yaml",
    ],
    license_type = "agpl-header",
    size = "small",
)
