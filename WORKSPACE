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

workspace(
    name = "vaticle_typedb_protocol",
    managed_directories = {"@npm": ["node_modules"]},
)

################################
# Load @vaticle_dependencies #
################################

load("//dependencies/vaticle:repositories.bzl", "vaticle_dependencies")
vaticle_dependencies()

# Load //builder/bazel for RBE
load("@vaticle_dependencies//builder/bazel:deps.bzl", "bazel_toolchain")
bazel_toolchain()

# Load //builder/java
load("@vaticle_dependencies//builder/java:deps.bzl", java_deps = "deps")
java_deps()

# Load //builder/kotlin
load("@vaticle_dependencies//builder/kotlin:deps.bzl", kotlin_deps = "deps")
kotlin_deps()
load("@io_bazel_rules_kotlin//kotlin:kotlin.bzl", "kotlin_repositories", "kt_register_toolchains")
kotlin_repositories()
kt_register_toolchains()

# Load //builder/python
load("@vaticle_dependencies//builder/python:deps.bzl", python_deps = "deps")
python_deps()

# Load //tool/common
load("@vaticle_dependencies//tool/common:deps.bzl", "vaticle_dependencies_ci_pip",
vaticle_dependencies_tool_maven_artifacts = "maven_artifacts")
vaticle_dependencies_ci_pip()

# Load //builder/grpc
load("@vaticle_dependencies//builder/grpc:deps.bzl", grpc_deps = "deps")
grpc_deps()
load("@com_github_grpc_grpc//bazel:grpc_deps.bzl",
com_github_grpc_grpc_deps = "grpc_deps")
com_github_grpc_grpc_deps()
load("@stackb_rules_proto//java:deps.bzl", "java_grpc_compile")
java_grpc_compile()
load("@stackb_rules_proto//node:deps.bzl", "node_grpc_compile")
node_grpc_compile()

# Load //tool/checkstyle
load("@vaticle_dependencies//tool/checkstyle:deps.bzl", checkstyle_deps = "deps")
checkstyle_deps()

# Load //tool/unuseddeps
load("@vaticle_dependencies//tool/unuseddeps:deps.bzl", unuseddeps_deps = "deps")
unuseddeps_deps()

######################################
# Load @vaticle_bazel_distribution #
######################################

load("@vaticle_dependencies//distribution:deps.bzl", "vaticle_bazel_distribution")
vaticle_bazel_distribution()

# Load //common
load("@vaticle_bazel_distribution//common:deps.bzl", "rules_pkg")
rules_pkg()
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
rules_pkg_dependencies()

# Load //pip
load("@vaticle_bazel_distribution//pip:deps.bzl", pip_deps = "deps")
pip_deps()

# Load //github
load("@vaticle_bazel_distribution//github:deps.bzl", github_deps = "deps")
github_deps()

# Load //maven
load("@vaticle_bazel_distribution//maven:deps.bzl", vaticle_bazel_distribution_maven_artifacts = "maven_artifacts")

############################
# Load @maven dependencies #
############################

load("@vaticle_dependencies//library/maven:rules.bzl", "maven")
load("//dependencies/maven:artifacts.bzl", "artifacts")
maven(artifacts + vaticle_dependencies_tool_maven_artifacts + vaticle_bazel_distribution_maven_artifacts)

##################################################
# Create @vaticle_typedb_protocol_workspace_refs #
##################################################

load("@vaticle_bazel_distribution//common:rules.bzl", "workspace_refs")
workspace_refs(
    name = "vaticle_typedb_protocol_workspace_refs"
)

#########################
# Load NPM dependencies #
#########################

load("@vaticle_dependencies//builder/nodejs:deps.bzl", nodejs_deps = "deps")
nodejs_deps(["@vaticle_dependencies//builder/nodejs:remove-node-patches.patch"])
load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories", "yarn_install")

node_repositories(
    preserve_symlinks = False,
)
yarn_install(
  name = "npm",
  package_json = "//grpc/nodejs:package.json",
  yarn_lock = "//grpc/nodejs:yarn.lock",
)
