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

exports_files(["VERSION"])
load("@graknlabs_bazel_distribution//github:rules.bzl", "deploy_github")
load("//:deployment.bzl", "deployment")

deploy_github(
    name = "deploy-github",
    organisation = deployment["github.organisation"],
    repository = deployment["github.repository"],
    release_description = "//:RELEASE_TEMPLATE.md",
    title = "Protocol",
    title_append_version = True,
)


# CI targets that are not declared in any BUILD file, but are called externally
filegroup(
    name = "ci",
    data = [
        "@graknlabs_dependencies//image/rbe:ubuntu-1604",
        "@graknlabs_dependencies//library/maven:update",
        "@graknlabs_dependencies//tool/bazelrun:rbe",
        "@graknlabs_dependencies//tool/unuseddeps:unused-deps",
        "@graknlabs_dependencies//tool/sync:dependencies",
        "@graknlabs_dependencies//tool/release:approval",
        "@graknlabs_dependencies//tool/release:create-notes",
    ],
)
