extern crate protoc_rust_grpc;

use std::fs;

fn main() {
    fs::create_dir("out");
    match protoc_rust_grpc::Codegen::new()
        .out_dir("out")
        .includes(&["."])
        .input("cluster/cluster_database.proto")
        .input("cluster/cluster_server.proto")
        .input("cluster/cluster_service.proto")
        .input("cluster/cluster_user.proto")
        .input("common/answer.proto")
        .input("common/concept.proto")
        .input("common/logic.proto")
        .input("common/options.proto")
        .input("common/query.proto")
        .input("common/session.proto")
        .input("common/transaction.proto")
        .input("core/core_database.proto")
        .input("core/core_service.proto")
        .rust_protobuf(true) // also generate protobuf messages, not just services
        .run() {
        Ok(res) => println!("{:?}", res),
        Err(err) => println!("{:?}", err)
    }
}
