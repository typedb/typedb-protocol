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

use std::env;

fn main() -> std::io::Result<()> {
    let protos_raw = env::var("PROTOS").expect("PROTOS environment variable is not set");
    let protos: Vec<&str> = protos_raw.split(";").filter(|&str| !str.is_empty()).collect();

    tonic_build::configure()
        .compile(&protos, &[
            env::var("PROTOS_ROOT").expect("PROTOS_ROOT environment variable is not set")
        ])
}
