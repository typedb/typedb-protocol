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
load("@rules_proto_grpc//java:defs.bzl", "java_grpc_library")

# NOTE: This rule only generates code for services; it does not generate code for messages...
java_grpc_library(
    name = "typedb-protocol",
    protos = [
        "//proto:service-proto",
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

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl-header",
    size = "small",
)

#assemble_maven(
#    name = "assemble-maven",
#    target = ":typedb-protocol",
#    version_overrides = version(artifacts_org = artifacts),
#    workspace_refs = "@vaticle_typedb_protocol_workspace_refs//:refs.json"
#)

#deploy_maven(
#    name = "deploy-maven",
#    target = ":assemble-maven",
#    snapshot = deployment["maven.snapshot"],
#    release = deployment["maven.release"],
#)
