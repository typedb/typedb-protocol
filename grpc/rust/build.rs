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

fn main() -> Result<(), Box<dyn std::error::Error>> {
    tonic_build::configure()
        .build_client(true)
        .build_server(true)
        .compile(
            &[
                "cluster/cluster_database.proto",
                "cluster/cluster_server.proto",
                "cluster/cluster_service.proto",
                "cluster/cluster_user.proto",
                "core/core_service.proto",
                "core/core_database.proto",
                "common/answer.proto",
                "common/concept.proto",
                "common/logic.proto",
                "common/options.proto",
                "common/query.proto",
                "common/session.proto",
                "common/transaction.proto"
            ],
            &[
                "../../"
            ],
        )?;
    Ok(())
}
