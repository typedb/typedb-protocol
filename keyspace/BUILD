#
# GRAKN.AI - THE KNOWLEDGE GRAPH
# Copyright (C) 2018 Grakn Labs Ltd
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

package(
    default_visibility = ["//visibility:public"]
)

load("@stackb_rules_proto//java:java_grpc_compile.bzl", "java_grpc_compile")
load("@graknlabs_build_tools//distribution/maven:rules.bzl", "assemble_maven", "deploy_maven")

proto_library(
    name = "keyspace-proto",
    srcs = ["Keyspace.proto"],
)

java_grpc_compile(
    name = "keyspace-src",
    deps = [":keyspace-proto"]
)

java_library(
    name = "keyspace",
    srcs = [":keyspace-src"],
    deps = [
        "//dependencies/maven/artifacts/com/google/guava:guava",
        "//dependencies/maven/artifacts/com/google/protobuf:protobuf-java",
        "//dependencies/maven/artifacts/io/grpc:grpc-core",
        "//dependencies/maven/artifacts/io/grpc:grpc-protobuf",
        "//dependencies/maven/artifacts/io/grpc:grpc-stub",
    ],
    tags = ["maven_coordinates=io.grakn.protocol:grakn-keyspace:{pom_version}", "checkstyle_ignore"],
)

assemble_maven(
    name = "assemble-maven",
    target = ":keyspace",
    package = "keyspace",
    version_file = "//:VERSION",
    workspace_refs = "@graknlabs_grakn_core_workspace_refs//:refs.json"
)

deploy_maven(
    name = "deploy-maven",
    target = ":assemble-maven"
)
