# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def typedb_dependencies():
    # TODO: Return typedb
    git_repository(
        name = "typedb_dependencies",
        remote = "https://github.com/farost/typedb-dependencies",
        commit = "24a0d12e3523c96a349e0742435194423f2dd1f9", # sync-marker: do not remove this comment, this is used for sync-dependencies by @typedb_dependencies
    )
