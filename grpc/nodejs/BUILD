# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

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
        "//proto:typedb-service",
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
    snapshot = deployment["npm"]["snapshot"],
    release = deployment["npm"]["release"],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    exclude = [
        "package.json",
        "pnpm-lock.yaml",
    ],
    license_type = "mpl-header",
    size = "small",
)
