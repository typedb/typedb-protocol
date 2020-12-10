#
# Copyright (C) 2020 Grakn Labs
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
load("@stackb_rules_proto//python:python_grpc_compile.bzl", "python_grpc_compile")
load("@graknlabs_bazel_distribution//pip:rules.bzl", "assemble_pip", "deploy_pip", "python_repackage")
load("@graknlabs_dependencies//distribution:deployment.bzl", "deployment")
load("@graknlabs_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")

python_grpc_compile(
    name = "protocol_src",
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
    visibility = ["//visibility:public"]
)

python_repackage(
    name = "protocol_pkg",
    src = ":protocol_src",
    package = "graknprotocol"
)

py_library(
    name = "protocol",
    srcs = ["protocol_pkg"],
    imports = ["../../grpc/python"]
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl",
    size = "small",
)

assemble_pip(
    name = "assemble-pip",
    target = ":protocol",
    package_name = "graknprotocol",
    classifiers = [
        "Programming Language :: Python",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.5",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "License :: OSI Approved :: GNU Affero General Public License v3 or later (AGPLv3+)",
        "Operating System :: OS Independent",
        "Intended Audience :: Developers",
        "Intended Audience :: Science/Research",
        "Environment :: Console",
        "Topic :: Database :: Front-Ends"
    ],
    url = "https://github.com/graknlabs/protocol/",
    author = "Grakn Labs",
    author_email = "grabl@grakn.ai",
    license = "AGPLv3+",
    install_requires = [],
    keywords = ["grakn", "database", "graph", "knowledgebase", "knowledge-engineering"],
    description = "Grakn gRPC Protocol",
    long_description_file = "//:README.md",
)

deploy_pip(
    name = "deploy-pip",
    target = ":assemble-pip",
    snapshot = deployment["pypi.snapshot"],
    release = deployment["pypi.release"],
)
