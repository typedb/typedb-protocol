Documentation: https://typedb.com/docs/drivers/

**This is an alpha release for CLUSTERED TypeDB 3.x. Do not use this as a stable version of TypeDB.**
**Instead, reference a non-alpha release of the same major and minor versions.**

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol@3.10.0-alpha-0
```

## New Features
### Introduce clustered servers

Introduce cluster support in the TypeDB protocol.

In TypeDB 2.x, each database response carried its own replica list (`DatabaseReplicas`). In TypeDB 3.x, servers are the unit of replication, and all databases on that server share the replication context.

- Replace per-database replica discovery with server-level discovery. On connection open, return `ServerManager.All.Res` (servers with replica status) instead of `DatabaseManager.All.Res` (databases with replicas).
- Add `servers_get` RPC to retrieve the specific server's replica status.
- Add `server_version` RPC to retrieve server distribution and version.
- Remove `DatabaseReplicas` message. Instead, return `Database` (name only) instead of `DatabaseReplicas` (name + replica info). Replica topology is a server-level concern.
- Replica information is now on `Server.ReplicaStatus` (replica ID, role, term).

**Breaking**: not compatible with previous versions.

## Bugs Fixed


## Code Refactors


## Other Improvements
