Documentation: https://typedb.com/docs/clients/2.x/clients

### Distribution

#### For Rust through cargo

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
npm install typedb-protocol
```
or
```sh
yarn install typedb-protocol
```


## New Features
- **Revamp unified TypeDB network API & simplify Concept requests**
  
  We merge core and cluster gRPC service definitions in order to unify the network interface between the two.
  TypeDB Core and TypeDB Cluster are now going to the same network interface to drivers.
  As part of this change, we simplify Concept API by merging related requests, replacing them with parameters.
  
  

## Bugs Fixed


## Code Refactors


## Other Improvements

    
