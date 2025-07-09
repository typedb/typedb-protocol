// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

fn main() -> std::io::Result<()> {
    let protos = vec![
        "../../proto/analyze.proto",
        "../../proto/answer.proto",
        "../../proto/authentication.proto",
        "../../proto/concept.proto",
        "../../proto/connection.proto",
        "../../proto/analyzed-conjunction.proto",
        "../../proto/database.proto",
        "../../proto/error.proto",
        "../../proto/migration.proto",
        "../../proto/options.proto",
        "../../proto/query.proto",
        "../../proto/server.proto",
        "../../proto/transaction.proto",
        "../../proto/typedb-service.proto",
        "../../proto/user.proto",
        "../../proto/version.proto",
        "../../proto/raft-peering.proto",
        "../../proto/raft-peering-service.proto",
    ];

    tonic_build::configure()
        .server_mod_attribute(".", "#[allow(non_camel_case_types)]")
        .client_mod_attribute(".", "#[allow(non_camel_case_types)]")
        .compile_protos(&protos, &["../.."])
}
