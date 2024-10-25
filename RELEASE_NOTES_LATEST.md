Documentation: https://typedb.com/docs/clients/2.x/clients

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol@3.0.0-alpha-7
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
npm install typedb-protocol@3.0.0-alpha-7
```
or
```sh
yarn add typedb-protocol@3.0.0-alpha-7
```


## New Features


## Bugs Fixed


## Code Refactors


## Other Improvements

- **Add query type to all Query responses**
  We add a `query_type` field to all the `Query.InitialRes.Ok` to support
  retrieval of this information for any `QueryAnswer` on the client side.
  Additionally, the `Ok.Empty` message was renamed to `Ok.Done`.
    
