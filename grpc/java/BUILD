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

load("@rules_proto//proto:defs.bzl", "proto_library")
load("@vaticle_bazel_distribution//maven:rules.bzl", "assemble_maven", "deploy_maven")
load("@vaticle_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@vaticle_dependencies//distribution/maven:version.bzl", "version")
load("@vaticle_dependencies//library/maven:artifacts.bzl", "artifacts")
load("@vaticle_dependencies//distribution:deployment.bzl", "deployment")
load("@rules_proto_grpc//java:defs.bzl", "java_proto_library")

java_proto_library(
    name = "typedb-protocol",
    protos = [
        "//cluster:service-proto",
        "//cluster:server-proto",
        "//cluster:user-proto",
        "//cluster:database-proto",
        "//common:answer-proto",
        "//common:concept-proto",
        "//common:connection-proto",
        "//common:logic-proto",
        "//common:options-proto",
        "//common:query-proto",
        "//common:session-proto",
        "//common:transaction-proto",
        "//common:version-proto",
        "//core:database-proto",
        "//core:service-proto",
    ],

#        "@maven//:com_google_guava_guava",
#        "@maven//:com_google_protobuf_protobuf_java",
#        "@maven//:io_grpc_grpc_core",
#        "@maven//:io_grpc_grpc_protobuf",
#        "@maven//:io_grpc_grpc_stub",
#        "@maven//:io_grpc_grpc_api",
#        "@maven//:javax_annotation_javax_annotation_api", # gRPC needs this in order to compile in Java 11 and Java 14
    tags = ["maven_coordinates=com.vaticle.typedb:typedb-protocol:{pom_version}", "checkstyle_ignore"],
)

#load("@rules_proto_grpc//java:defs.bzl", "java_proto_compile")

#java_proto_compile(
#    name = "typedb-protocol-compiled",
#    protos = ["//common:options-proto"]
#)

#java_proto_library(
#    name = "typedb-protocol-java",
##    protos = ["//core:service-proto"],
##    deps = [":typedb-protocol"],
#    protos = ["//common:options-proto"]
#)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl-header",
    size = "small",
)

assemble_maven(
    name = "assemble-maven",
    target = ":typedb-protocol",
    version_overrides = version(artifacts_org = artifacts),
    workspace_refs = "@vaticle_typedb_protocol_workspace_refs//:refs.json"
)

deploy_maven(
    name = "deploy-maven",
    target = ":assemble-maven",
    snapshot = deployment["maven.snapshot"],
    release = deployment["maven.release"],
)
