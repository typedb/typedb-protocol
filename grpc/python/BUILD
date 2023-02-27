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
load("@stackb_rules_proto//python:python_grpc_compile.bzl", "python_grpc_compile")
load("@vaticle_bazel_distribution//pip:rules.bzl", "assemble_pip", "deploy_pip", "python_repackage")
load("@vaticle_dependencies//distribution:deployment.bzl", "deployment")
load("@vaticle_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")


python_grpc_compile(
    name = "typedb-protocol-src",
    deps = [
        "//service:server-proto",
        "//service:user-proto",
        "//service:database-proto",
        "//service:service-proto",
        "//common:answer-proto",
        "//common:concept-proto",
        "//common:logic-proto",
        "//common:options-proto",
        "//common:query-proto",
        "//common:session-proto",
        "//common:transaction-proto",
    ],
    visibility = ["//visibility:public"]
)

python_repackage(
    name = "typedb-protocol-pkg",
    src = ":typedb-protocol-src",
    src_packages = ["common", "service"],
    py_package_add_prefix = "typedb_protocol",
)

py_library(
    name = "typedb-protocol",
    srcs = ["typedb-protocol-pkg"],
    imports = ["../../../grpc/python"]
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    license_type = "agpl-header",
    size = "small",
)

assemble_pip(
    name = "assemble-pip",
    target = ":typedb-protocol",
    package_name = "typedb-protocol",
    classifiers = [
        "Programming Language :: Python",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "License :: OSI Approved :: GNU Affero General Public License v3 or later (AGPLv3+)",
        "Operating System :: OS Independent",
        "Intended Audience :: Developers",
        "Intended Audience :: Science/Research",
        "Environment :: Console",
        "Topic :: Database :: Front-Ends"
    ],
    url = "https://github.com/vaticle/typedb-protocol/",
    author = "Vaticle",
    author_email = "community@vaticle.com",
    license = "AGPL-3.0",
    requirements_file = ":requirements.txt",
    keywords = ["typedb", "typeql", "type-system", "strongly-typed", "database", "knowledge-base"],
    description = "TypeDB Protocol",
    long_description_file = "//:README.md",
    python_requires = ">3.6.0",
)

deploy_pip(
    name = "deploy-pip",
    target = ":assemble-pip",
    snapshot = deployment["pypi.snapshot"],
    release = deployment["pypi.release"],
)
