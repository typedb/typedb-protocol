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

exports_files(["VERSION", "python_proto.py"])
load("@graknlabs_bazel_distribution//github:rules.bzl", "deploy_github")

deploy_github(
    name = "deploy-github",
    deployment_properties = "//:deployment.properties",
    release_description = "//:RELEASE_TEMPLATE.md",
    version_file = "//:VERSION"
)

genrule(
    name = "python-package-structure",
    srcs = [
        "//keyspace:Keyspace.proto",
        "//session:Session.proto",
        "//session:Concept.proto",
        "//session:Answer.proto",
    ],
    cmd = "$(location :python_proto.py) --pkg grakn_protocol --srcs $(SRCS) --outs $(OUTS)",
    outs = [
        "grakn_protocol/keyspace/Keyspace.proto",
        "grakn_protocol/session/Session.proto",
        "grakn_protocol/session/Concept.proto",
        "grakn_protocol/session/Answer.proto",
    ],
    tools = [":python_proto.py"]
)


proto_library(
    name = "python-protos",
    srcs = [":python-package-structure"],
)
