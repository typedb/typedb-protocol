load("@rules_rust//proto:proto.bzl", "rust_grpc_library")
load("@rules_rust//proto:toolchain.bzl", "rust_proto_toolchain")

rust_proto_toolchain(
    name = "proto_toolchain_impl",
    # Path to the protobuf compiler.
    protoc = "@com_google_protobuf//:protoc",
    # Protobuf compiler plugin to generate rust gRPC stubs.
    grpc_plugin = "@vaticle_dependencies//library/crates:cargo_bin_protoc_gen_rust_grpc",
    # Protobuf compiler plugin to generate rust protobuf stubs.
    proto_plugin = "@vaticle_dependencies//library/crates:cargo_bin_protoc_gen_rust",
)

toolchain(
    name = "proto_toolchain",
    toolchain = ":proto_toolchain_impl",
    toolchain_type = "@rules_rust//proto:toolchain",
)

rust_grpc_library(
    name = "typedb_protocol_src",
    deps = [
        "//cluster:service-proto",
        "//cluster:server-proto",
        "//cluster:user-proto",
        "//cluster:database-proto",
        "//common:answer-proto",
        "//common:concept-proto",
        "//common:logic-proto",
        "//common:options-proto",
        "//common:query-proto",
        "//common:session-proto",
        "//common:transaction-proto",
        "//core:database-proto",
        "//core:service-proto",
    ]
)

# TODO: add assemble_crate and deploy_crate targets
