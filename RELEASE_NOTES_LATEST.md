Documentation: https://typedb.com/docs/drivers/

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol@3.15.0-rc0
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
npm install typedb-protocol@3.15.0-rc0
```
or
```sh
yarn add typedb-protocol@3.15.0-rc0
```


## New Features
- **Add optimized migration proto fields**
  
  We add protocol fields for optimized TypeDB Import, adding extensions
  for Migration items to provide fixed, label-scoped IDs for entities and
  relations, map linked role players by label-scoped ID, and map attribute
  ownerships by value. 
  
  These changes are forward and backward compatible, so we don't force a protocol version bump.
  
- **Add IsSet to analyze response**
  Add the `isset` constraint to the analyze response

## Other Improvements
- **Update version.proto**
  
  Update Extension version number to reflect https://github.com/typedb/typedb-protocol/pull/257 
  
  
- **Update version.proto**

    
