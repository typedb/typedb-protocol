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
load("@graknlabs_dependencies//tool/checkstyle:rules.bzl", "checkstyle_test")
load("@build_bazel_rules_nodejs//:index.bzl", "pkg_npm", "nodejs_binary")
load("@graknlabs_bazel_distribution//npm:rules.bzl", "assemble_npm", "deploy_npm")
load("@graknlabs_dependencies//distribution:deployment.bzl", "deployment")
load("//:deployment.bzl", github_deployment = "deployment")


nodejs_binary(
  name = "grpc_tools_node_protoc",
  data = ["@npm//grpc-tools:grpc-tools"],
  entry_point = "@npm//:node_modules/grpc-tools/bin/protoc.js",
  templated_args = ["--nobazel_node_patches"],
)

nodejs_binary(
  name = "protoc-gen-ts",
  data = ["@npm//grpc_tools_node_protoc_ts:grpc_tools_node_protoc_ts"],
  entry_point = "@npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts",
  templated_args = ["--nobazel_node_patches"],
)


genrule(
    name = "protocol",
    outs = [
        "protobuf/answer_pb.d.ts",
        "protobuf/answer_pb.js",
        "protobuf/concept_pb.d.ts",
        "protobuf/concept_pb.js",
        "protobuf/database_pb.d.ts",
        "protobuf/database_pb.js",
        "protobuf/grakn_pb.d.ts",
        "protobuf/grakn_pb.js",
        "protobuf/grakn_grpc_pb.js",
        "protobuf/grakn_grpc_pb.d.ts",
        "protobuf/options_pb.d.ts",
        "protobuf/options_pb.js",
        "protobuf/query_pb.d.ts",
        "protobuf/query_pb.js",
        "protobuf/session_pb.d.ts",
        "protobuf/session_pb.js",
        "protobuf/transaction_pb.d.ts",
        "protobuf/transaction_pb.js",
    ],
    # The below command performs a protoc compilation of our proto files into typescript and javascript. Line by line:
    # Symlink the node modules required by the typescript plugin into the directory the command will be run from
    # Run the node.js protoc (protocol compiler) with the following flags:
    #    Use the gen-ts plugin to generate typescript declaration files in addition to javascript
    #    Output javascript with commonjs style exports, to the genrule output directory.
    #    Output services to the genrule output directory (without this line, grakn_grpc_pb is omitted)
    #    Output typescript to (you guessed it) the genrule output directory
    #    Set the .proto file relative path to the WORKSPACE this command is being run from
    #    Use the .proto files found in the :proto-raw-buffers filegroup as inputs.
    cmd = "ln -s $(execpath //grpc/nodejs:protoc-gen-ts).runfiles/npm/node_modules ./node_modules ;\
        $(execpath //grpc/nodejs:grpc_tools_node_protoc) \
            --plugin='protoc-gen-ts=$(rootpath @npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts)' \
            --js_out='import_style=commonjs,binary:./$(@D)/' \
            --grpc_out='grpc_js:./$(@D)/' \
            --ts_out='grpc_js:./$(@D)/' \
            --proto_path=`dirname $(execpath //:WORKSPACE)` \
            $(execpaths //protobuf:proto-raw-buffers);",
    # Dependencies for the above command. the //:WORKSPACE label is required to locate the relative path for the .proto files so they can import each other.
    tools = [
        "//grpc/nodejs:grpc_tools_node_protoc",
        "//grpc/nodejs:protoc-gen-ts",
        "@npm//:node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts",
        "@npm//grpc_tools_node_protoc_ts",
        "@npm//google-protobuf",
        "//protobuf:proto-raw-buffers",
        "//:WORKSPACE"
    ],
)

pkg_npm(
    name = "protocol-package",
    package_name = "graknlabs_protocol",
    srcs = glob([
        "package.json",
    ]),
    deps = [
        ":protocol",
    ],
)

assemble_npm(
    name = "assemble-npm",
    target = ":protocol-package",
)

deploy_npm(
    name = "deploy-npm",
    target = ":assemble-npm",
    snapshot = deployment["npm.snapshot"],
    release = deployment["npm.release"],
)

checkstyle_test(
    name = "checkstyle",
    include = glob(["*"]),
    exclude = ["package.json"],
    license_type = "agpl",
    size = "small",
)
