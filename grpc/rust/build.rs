// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

fn main() -> std::io::Result<()> {
    let protos = vec![
        "../../proto/raft_service/replication.proto",
        "../../proto/raft_service/raft_service.proto",
        "../../proto/typedb_clustering_service/typedb_clustering.proto",
        "../../proto/typedb_clustering_service/typedb_clustering_service.proto",
        "../../proto/typedb_service/analyze.proto",
        "../../proto/typedb_service/analyzed-conjunction.proto",
        "../../proto/typedb_service/answer.proto",
        "../../proto/typedb_service/authentication.proto",
        "../../proto/typedb_service/concept.proto",
        "../../proto/typedb_service/connection.proto",
        "../../proto/typedb_service/database.proto",
        "../../proto/typedb_service/error.proto",
        "../../proto/typedb_service/migration.proto",
        "../../proto/typedb_service/options.proto",
        "../../proto/typedb_service/query.proto",
        "../../proto/typedb_service/server.proto",
        "../../proto/typedb_service/transaction.proto",
        "../../proto/typedb_service/typedb_service.proto",
        "../../proto/typedb_service/user.proto",
        "../../proto/version.proto",
        "../../proto/raft-peering.proto",
        "../../proto/raft-peering-service.proto",
    ];

    tonic_build::configure()
        .server_mod_attribute(".", "#[allow(non_camel_case_types)]")
        .client_mod_attribute(".", "#[allow(non_camel_case_types)]")
        .compile_protos(&protos, &["../.."])
}
