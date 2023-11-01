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

exports_files(["VERSION", "package.json"])
load("@vaticle_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@vaticle_bazel_distribution//github:rules.bzl", "deploy_github")
load("//:deployment.bzl", "deployment")

checkstyle_test(
    name = "checkstyle",
    include = glob([
        ".bazelrc",
        ".gitignore",
        "BUILD",
        "deployment.bzl",
        "WORKSPACE",
        ".factory/automation.yml",
    ]),
    license_type = "agpl-header",
    size = "small",
)

checkstyle_test(
    name = "checkstyle-license",
    include = ["LICENSE"],
    license_type = "agpl-fulltext",
    size = "small",
)

deploy_github(
    name = "deploy-github",
    organisation = deployment["github.organisation"],
    repository = deployment["github.repository"],
    release_description = "//:RELEASE_NOTES_LATEST.md",
    title = "TypeDB Protocol",
    title_append_version = True,
    draft = False,
)

exports_files(["README.md"])

# Tools to be built during `build //...`
filegroup(
    name = "tools",
    data = [
        "@vaticle_dependencies//library/maven:update",
        "@vaticle_dependencies//tool/ide:rust_sync",
        "@vaticle_dependencies//tool/unuseddeps:unused-deps",
        "@vaticle_dependencies//tool/release/notes:create",
    ],
)
