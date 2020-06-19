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

workspace(name = "graknlabs_protocol")


###########################
# Grakn Labs Dependencies #
###########################

load("//dependencies/graknlabs:dependencies.bzl", "graknlabs_build_tools")
graknlabs_build_tools()

load("@graknlabs_build_tools//distribution:deps.bzl", graknlabs_bazel_distribution = "deps")
graknlabs_bazel_distribution()

load("@graknlabs_build_tools//tools/unused_deps:deps.bzl", unused_deps_deps = "deps")
unused_deps_deps()

###########################
# Load Bazel dependencies #
###########################

load("@graknlabs_build_tools//builder/bazel:deps.bzl", "bazel_common", "bazel_deps", "bazel_toolchain")
bazel_common()
bazel_deps()
bazel_toolchain()


#################################
# Load Build Tools dependencies #
#################################

load("@graknlabs_build_tools//tools/checkstyle:deps.bzl", checkstyle_deps = "deps")
checkstyle_deps()

load("@graknlabs_build_tools//builder/java:deps.bzl", java_deps = "deps")
java_deps()

load("@graknlabs_build_tools//builder/python:deps.bzl", python_deps = "deps")
python_deps()

load("@rules_python//python:repositories.bzl", "py_repositories")
py_repositories()

load("@rules_python//python:pip.bzl", "pip_repositories", "pip3_import")
pip_repositories()

pip3_import(
    name = "graknlabs_build_tools_ci_pip",
    requirements = "@graknlabs_build_tools//tools:requirements.txt",
)

load("@graknlabs_build_tools_ci_pip//:requirements.bzl",
graknlabs_build_tools_ci_pip_install = "pip_install")
graknlabs_build_tools_ci_pip_install()


pip3_import(
    name = "graknlabs_bazel_distribution_pip",
    requirements = "@graknlabs_bazel_distribution//pip:requirements.txt",
)
load("@graknlabs_bazel_distribution_pip//:requirements.bzl",
graknlabs_bazel_distribution_pip_install = "pip_install")
graknlabs_bazel_distribution_pip_install()

################################################################
# Load Java dependencies and rules from @graknlabs_build_tools #
################################################################

load("@graknlabs_build_tools//library/maven:rules.bzl", "maven")
load("//dependencies/maven:artifacts.bzl", "artifacts")
maven(artifacts)

#####################################
# Load Java dependencies from Maven #
#####################################

load("//dependencies/maven:dependencies.bzl", "maven_dependencies")
maven_dependencies()

#######################################
# Load compiler dependencies for GRPC #
#######################################

load("@graknlabs_build_tools//builder/grpc:deps.bzl", grpc_deps = "deps")
grpc_deps()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl",
com_github_grpc_grpc_deps = "grpc_deps")
com_github_grpc_grpc_deps()

load("@stackb_rules_proto//java:deps.bzl", "java_grpc_compile")
java_grpc_compile()

load("@stackb_rules_proto//node:deps.bzl", "node_grpc_compile")
node_grpc_compile()

##################################
# Load Distribution dependencies #
##################################

load("@graknlabs_bazel_distribution//github:dependencies.bzl", "tcnksm_ghr")
tcnksm_ghr()

load("@graknlabs_bazel_distribution//common:dependencies.bzl", "bazelbuild_rules_pkg")
bazelbuild_rules_pkg()


#####################################
# Load Bazel common workspace rules #
#####################################

# TODO: Figure out why this cannot be loaded at earlier at the top of the file
load("@com_github_google_bazel_common//:workspace_defs.bzl", "google_common_workspace_rules")
google_common_workspace_rules()


# Generate a JSON document of commit hashes of all external workspace dependencies
load("@graknlabs_bazel_distribution//common:rules.bzl", "workspace_refs")
workspace_refs(
    name = "graknlabs_protocol_workspace_refs"
)
