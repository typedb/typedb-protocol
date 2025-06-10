Documentation: https://typedb.com/docs/drivers/

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol@3.4.0-rc0
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
npm install typedb-protocol@3.4.0-rc0
```
or
```sh
yarn add typedb-protocol@3.4.0-rc0
```


## New Features
- **Introduce database import and export protocol messages**
  Add `migration` protocol messages for usage in database import and database export operations:
  * a unidirectional `database_export` stream from a TypeDB server to export a specific database, similar to TypeDB 2.x;
  * a bidirectional `databases_import` stream between a client and a server to import an exported 2.x/3.x TypeDB database into a TypeDB 3.x server from a client.
  
  The format of migration items used for these operations is an extended version of TypeDB 2.x's migration items, so it is backward compatible with 2.x database files. **Important:** it's not intended to import 3.x databases into 2.x servers.
  
  

## Bugs Fixed


## Code Refactors


## Other Improvements

    
