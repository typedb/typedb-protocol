//
// Copyright (C) 2022 Vaticle
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

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
