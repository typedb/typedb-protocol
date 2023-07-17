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

workspace(name = "vaticle_typedb_protocol")

################################
# Load @vaticle_dependencies #
################################

load("//dependencies/vaticle:repositories.bzl", "vaticle_dependencies")
vaticle_dependencies()

# Load //builder/python
load("@vaticle_dependencies//builder/python:deps.bzl", python_deps = "deps")
python_deps()

load("@rules_python//python:repositories.bzl", "py_repositories", "python_register_toolchains")
py_repositories()
python_register_toolchains(
    name = "python39",
    python_version = "3.9",
)

# Load //builder/java
load("@vaticle_dependencies//builder/java:deps.bzl", java_deps = "deps")
java_deps()

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")
rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")
rules_jvm_external_setup()

# Load //builder/kotlin
load("@vaticle_dependencies//builder/kotlin:deps.bzl", kotlin_deps = "deps")
kotlin_deps()
load("@io_bazel_rules_kotlin//kotlin:repositories.bzl", "kotlin_repositories")
kotlin_repositories()
load("@io_bazel_rules_kotlin//kotlin:core.bzl", "kt_register_toolchains")
kt_register_toolchains()

# Load //builder/rust
load("@vaticle_dependencies//builder/rust:deps.bzl", rust_deps = "deps")
rust_deps()

load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")
rules_rust_dependencies()
rust_register_toolchains(edition = "2021", include_rustc_srcs = True)

load("@vaticle_dependencies//library/crates:crates.bzl", "fetch_crates")
fetch_crates()
load("@crates//:defs.bzl", "crate_repositories")
crate_repositories()

# Load //tool/common
load("@vaticle_dependencies//tool/common:deps.bzl", "vaticle_dependencies_ci_pip",
vaticle_dependencies_tool_maven_artifacts = "maven_artifacts")
vaticle_dependencies_ci_pip()

# Load //builder/grpc
load("@vaticle_dependencies//builder/grpc:deps.bzl", vaticle_grpc_deps = "deps")
vaticle_grpc_deps()

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_repos", "rules_proto_grpc_toolchains")
rules_proto_grpc_toolchains()
rules_proto_grpc_repos()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()

load("@rules_proto_grpc//python:repositories.bzl", rules_proto_grpc_python_repos = "python_repos")
rules_proto_grpc_python_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
grpc_deps(python_headers = "@python39//:python_headers",)

load("@com_github_grpc_grpc//bazel:grpc_extra_deps.bzl", "grpc_extra_deps")
grpc_extra_deps()

load("@rules_python//python:pip.bzl", "pip_parse")
pip_parse(
    name = "rules_proto_grpc_py3_deps",
    python_interpreter = "python3",
    requirements_lock = "@rules_proto_grpc//python:requirements.txt",
)

load("@rules_proto_grpc_py3_deps//:requirements.bzl", "install_deps")
install_deps()

# Load //tool/checkstyle
load("@vaticle_dependencies//tool/checkstyle:deps.bzl", checkstyle_deps = "deps")
checkstyle_deps()

# Load //tool/unuseddeps
load("@vaticle_dependencies//tool/unuseddeps:deps.bzl", unuseddeps_deps = "deps")
unuseddeps_deps()

## Load //pip
load("@vaticle_dependencies//distribution:deps.bzl", "vaticle_bazel_distribution")
vaticle_bazel_distribution()

load("@vaticle_bazel_distribution//pip:deps.bzl", pip_deps = "deps")
pip_deps()

# Load //github
load("@vaticle_bazel_distribution//github:deps.bzl", github_deps = "deps")
github_deps()

# Load //maven
load("@vaticle_bazel_distribution//maven:deps.bzl", vaticle_bazel_distribution_maven_artifacts = "maven_artifacts")

# Load //builder/rust
load("@vaticle_dependencies//builder/rust:deps.bzl", rust_deps = "deps")
rust_deps()

load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")
rules_rust_dependencies()
rust_register_toolchains(edition = "2021", include_rustc_srcs = True)

load("@vaticle_dependencies//library/crates:crates.bzl", "fetch_crates")
fetch_crates()
load("@crates//:defs.bzl", "crate_repositories")
crate_repositories()

# Load //tool/common
load("@vaticle_dependencies//tool/common:deps.bzl", "vaticle_dependencies_ci_pip",
vaticle_dependencies_tool_maven_artifacts = "maven_artifacts")
vaticle_dependencies_ci_pip()

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

# Load //builder/nodejs
load("@vaticle_dependencies//builder/nodejs:deps.bzl", nodejs_deps = "deps")
nodejs_deps()

load("@build_bazel_rules_nodejs//:repositories.bzl", "build_bazel_rules_nodejs_dependencies")
build_bazel_rules_nodejs_dependencies()

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories", "yarn_install")
node_repositories(
    node_version = "17.9.1"
)

yarn_install(
    name = "npm",
    package_json = "//grpc/nodejs:package.json",
    yarn_lock = "//grpc/nodejs:yarn.lock",
    exports_directories_only = False,
)
