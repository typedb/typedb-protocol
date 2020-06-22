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

################################
# Load @graknlabs_dependencies #
################################

load("//dependencies/graknlabs:dependencies.bzl", "graknlabs_dependencies")
graknlabs_dependencies()

load("@graknlabs_dependencies//builder/bazel:deps.bzl","bazel_common", "bazel_deps", "bazel_toolchain")
bazel_common()
bazel_deps()
bazel_toolchain()

load("@graknlabs_dependencies//builder/grpc:deps.bzl", grpc_deps = "deps")
grpc_deps()
load("@com_github_grpc_grpc//bazel:grpc_deps.bzl",
com_github_grpc_grpc_deps = "grpc_deps")
com_github_grpc_grpc_deps()
load("@stackb_rules_proto//java:deps.bzl", "java_grpc_compile")
java_grpc_compile()
load("@stackb_rules_proto//node:deps.bzl", "node_grpc_compile")
node_grpc_compile()

load("@graknlabs_dependencies//builder/java:deps.bzl", java_deps = "deps")
java_deps()

load("@graknlabs_dependencies//builder/nodejs:deps.bzl", nodejs_deps = "deps")
nodejs_deps()
load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories")
node_repositories()

load("@graknlabs_dependencies//builder/python:deps.bzl", python_deps = "deps")
python_deps()
load("@rules_python//python:pip.bzl", "pip_repositories", "pip3_import")
pip_repositories()
pip3_import(
    name = "graknlabs_dependencies_ci_pip",
    requirements = "@graknlabs_dependencies//tools:requirements.txt",
)
load("@graknlabs_dependencies_ci_pip//:requirements.bzl",
graknlabs_dependencies_ci_pip_install = "pip_install")
graknlabs_dependencies_ci_pip_install()

load("@graknlabs_dependencies//distribution:deps.bzl", distribution_deps = "deps")
distribution_deps()

pip3_import(
    name = "graknlabs_bazel_distribution_pip",
    requirements = "@graknlabs_bazel_distribution//pip:requirements.txt",
)
load("@graknlabs_bazel_distribution_pip//:requirements.bzl",
graknlabs_bazel_distribution_pip_install = "pip_install")
graknlabs_bazel_distribution_pip_install()

load("@graknlabs_bazel_distribution//github:dependencies.bzl", "tcnksm_ghr")
tcnksm_ghr()

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
git_repository(
    name = "io_bazel_skydoc",
    remote = "https://github.com/graknlabs/skydoc.git",
    branch = "experimental-skydoc-allow-dep-on-bazel-tools",
)

load("@io_bazel_skydoc//:setup.bzl", "skydoc_repositories")
skydoc_repositories()

load("@io_bazel_rules_sass//:package.bzl", "rules_sass_dependencies")
rules_sass_dependencies()

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories")
node_repositories()

load("@io_bazel_rules_sass//:defs.bzl", "sass_repositories")
sass_repositories()

load("@graknlabs_bazel_distribution//common:dependencies.bzl", "bazelbuild_rules_pkg")
bazelbuild_rules_pkg()

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
rules_pkg_dependencies()

load("@graknlabs_dependencies//distribution/docker:deps.bzl", docker_deps = "deps")
docker_deps()

load("@graknlabs_dependencies//tools/checkstyle:deps.bzl", checkstyle_deps = "deps")
checkstyle_deps()

load("@graknlabs_dependencies//tools/sonarcloud:deps.bzl", "sonarcloud_dependencies")
sonarcloud_dependencies()

load("@graknlabs_dependencies//tools/unuseddeps:deps.bzl", unuseddeps_deps = "deps")
unuseddeps_deps()

########################
# Load Maven Artifacts #
########################
load("@graknlabs_dependencies//library/maven:rules.bzl", "maven")
load("//dependencies/maven:artifacts.bzl", "artifacts")
maven(artifacts)

#########################
# Create Workspace Refs #
#########################
load("@graknlabs_bazel_distribution//common:rules.bzl", "workspace_refs")
workspace_refs(
    name = "graknlabs_protocol_workspace_refs"
)

# ###########################
# # Grakn Labs Dependencies #
# ###########################

# load("//dependencies/graknlabs:dependencies.bzl", "graknlabs_dependencies")
# graknlabs_dependencies()

# load("@graknlabs_dependencies//distribution:deps.bzl", graknlabs_bazel_distribution = "deps")
# graknlabs_bazel_distribution()

# ###########################
# # Load Bazel dependencies #
# ###########################

# load("@graknlabs_dependencies//builder/bazel:deps.bzl", "bazel_common", "bazel_toolchain")
# bazel_common()
# bazel_toolchain()

# #################################
# # Load Build Tools dependencies #
# #################################

# load("@graknlabs_dependencies//tools/checkstyle:deps.bzl", checkstyle_deps = "deps")
# checkstyle_deps()

# load("@graknlabs_dependencies//builder/java:deps.bzl", java_deps = "deps")
# java_deps()

# load("@graknlabs_dependencies//builder/python:deps.bzl", python_deps = "deps")
# python_deps()

# load("@rules_python//python:repositories.bzl", "py_repositories")
# py_repositories()

# load("@rules_python//python:pip.bzl", "pip_repositories", "pip3_import")
# pip_repositories()

# pip3_import(
#     name = "graknlabs_dependencies_ci_pip",
#     requirements = "@graknlabs_dependencies//tools:requirements.txt",
# )

# load("@graknlabs_dependencies_ci_pip//:requirements.bzl",
# graknlabs_dependencies_ci_pip_install = "pip_install")
# graknlabs_dependencies_ci_pip_install()


# pip3_import(
#     name = "graknlabs_bazel_distribution_pip",
#     requirements = "@graknlabs_bazel_distribution//pip:requirements.txt",
# )
# load("@graknlabs_bazel_distribution_pip//:requirements.bzl",
# graknlabs_bazel_distribution_pip_install = "pip_install")
# graknlabs_bazel_distribution_pip_install()

# ##########################
# # Load Java dependencies #
# ##########################

# load("@graknlabs_dependencies//library/maven:rules.bzl", "maven")
# load("//dependencies/maven:artifacts.bzl", "artifacts")
# maven(artifacts)

# #######################################
# # Load compiler dependencies for GRPC #
# #######################################

# load("@graknlabs_dependencies//builder/grpc:deps.bzl", grpc_deps = "deps")
# grpc_deps()

# load("@com_github_grpc_grpc//bazel:grpc_deps.bzl",
# com_github_grpc_grpc_deps = "grpc_deps")
# com_github_grpc_grpc_deps()

# load("@stackb_rules_proto//java:deps.bzl", "java_grpc_compile")
# java_grpc_compile()

# load("@stackb_rules_proto//node:deps.bzl", "node_grpc_compile")
# node_grpc_compile()

# ##################################
# # Load Distribution dependencies #
# ##################################

# load("@graknlabs_bazel_distribution//github:dependencies.bzl", "tcnksm_ghr")
# tcnksm_ghr()

# load("@graknlabs_bazel_distribution//common:dependencies.bzl", "bazelbuild_rules_pkg")
# bazelbuild_rules_pkg()


# #####################################
# # Load Bazel common workspace rules #
# #####################################

# # TODO: Figure out why this cannot be loaded at earlier at the top of the file
# load("@com_github_google_bazel_common//:workspace_defs.bzl", "google_common_workspace_rules")
# google_common_workspace_rules()


# # Generate a JSON document of commit hashes of all external workspace dependencies
# load("@graknlabs_bazel_distribution//common:rules.bzl", "workspace_refs")
# workspace_refs(
#     name = "graknlabs_protocol_workspace_refs"
# )
