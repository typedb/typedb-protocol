Documentation: https://typedb.com/docs/drivers/

### Breaking change!
This version breaks backward compatibility.
Drivers built using this version (or newer) will be rejected by servers running older versions.   

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol@3.11.0-rc0
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
npm install typedb-protocol@3.11.0-rc0
```
or
```sh
yarn add typedb-protocol@3.11.0-rc0
```


## New Features
- **Introduce clustered servers**
  
  Introduce cluster support in the TypeDB protocol.
  
  In TypeDB 2.x, each database response carried its own replica list (`DatabaseReplicas`). In TypeDB 3.x, servers are the unit of replication, and all databases on that server share the replication context.
  
  - Replace per-database replica discovery with server-level discovery. On connection open, return `ServerManager.All.Res` (servers with replica status) instead of `DatabaseManager.All.Res` (databases with replicas).
  - Add `servers_get` RPC to retrieve the specific server's replica status.
  - Add `server_version` RPC to retrieve server distribution and version.
  - Remove `DatabaseReplicas` message. Instead, return `Database` (name only) instead of `DatabaseReplicas` (name + replica info). Replica topology is a server-level concern.
  - Replica information is now on `Server.ReplicaStatus` (replica ID, role, term).
  
  **Breaking**: not compatible with previous versions.


## Other Improvements
- **Upgrade Rust toolchain and update dependencies**
  
  We update Rust toolchain to 1.93.0, as well as dependencies.
  
  
    
