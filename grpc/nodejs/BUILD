# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

package(default_visibility = ["//visibility:public"])
load("@typedb_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@typedb_bazel_distribution//npm:rules.bzl", "assemble_npm", "deploy_npm")
load("@typedb_dependencies//distribution:deployment.bzl", "deployment")
load("@aspect_rules_js//npm:defs.bzl", "npm_package")
load("@aspect_rules_ts//ts:defs.bzl", "ts_project")
load("@typedb_protocol_npm//:defs.bzl", "npm_link_all_packages")
load("//:deployment.bzl", github_deployment = "deployment")
load("//grpc/nodejs:rules.bzl", "ts_grpc_compile")

npm_link_all_packages(name = "node_modules")

exports_files(["package.json", "pnpm-lock.yaml"])

load("@typedb_protocol_npm//grpc/nodejs:protoc-gen-ts/package_json.bzl", protoc_gen_ts_bin = "bin")

protoc_gen_ts_bin.protoc_gen_ts_binary(
    name = "protoc-gen-ts",
)

ts_grpc_compile(
    name = "typedb-protocol-src",
    deps = [
        "//proto:version-proto",
        "//proto/raft_service:raft-service",
        "//proto/raft_service:replication-proto",
        "//proto/typedb_clustering_service:typedb-clustering-service",
        "//proto/typedb_clustering_service:typedb-clustering-proto",
        "//proto/typedb_service:answer-proto",
        "//proto/typedb_service:authentication-proto",
        "//proto/typedb_service:concept-proto",
        "//proto/typedb_service:connection-proto",
        "//proto/typedb_service:database-proto",
        "//proto/typedb_service:error-proto",
        "//proto/typedb_service:migration-proto",
        "//proto/typedb_service:options-proto",
        "//proto/typedb_service:query-proto",
        "//proto/typedb_service:server-proto",
        "//proto/typedb_service:transaction-proto",
        "//proto/typedb_service:typedb-service",
        "//proto/typedb_service:user-proto",
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
    transpiler = "tsc",
    visibility = ["//visibility:public"],
)

npm_package(
    name = "typedb-protocol-package",
    srcs = [":typedb-protocol", "package.json"],
    include_runfiles = False,
    package = "typedb-protocol",
    include_external_repositories = ["typedb_protocol"],
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
