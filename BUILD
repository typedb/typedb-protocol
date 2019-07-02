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

package(default_visibility = ["//visibility:public"])

exports_files(["VERSION"])
load("@graknlabs_bazel_distribution//github:rules.bzl", "deploy_github")
load("@stackb_rules_proto//python:python_grpc_library.bzl", "python_grpc_library")

deploy_github(
    name = "deploy-github",
    deployment_properties = "//:deployment.properties",
    release_description = "//:RELEASE_TEMPLATE.md",
    version_file = "//:VERSION"
)

python_grpc_library(
    name = "grakn_protocol",
    deps = [
        "//keyspace:keyspace-proto",
        "//session:session-proto",
        "//session:answer-proto",
        "//session:concept-proto",
    ],
    visibility = ["//visibility:public"]
)
