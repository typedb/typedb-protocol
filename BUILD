# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

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
    exclude = [
        ".bazel-remote-cache.rc",
        ".bazel-cache-credential.json",
    ],
    license_type = "mpl-header",
    size = "small",
)

checkstyle_test(
    name = "checkstyle-license",
    include = ["LICENSE"],
    license_type = "mpl-fulltext",
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
        "@vaticle_dependencies//tool/sync:dependencies",
    ],
)
