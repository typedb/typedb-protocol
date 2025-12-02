Documentation: https://typedb.com/docs/drivers/

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol@3.7.0
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
npm install typedb-protocol@3.7.0
```
or
```sh
yarn add typedb-protocol@3.7.0
```


## New Features
- **Introduce version extension**
  We introduce the "extension" field into the protocol. This introduces a finer notion of "compatibility" and makes the protocol aware of it.
  A driver-server pair is compatible if they are on the same protocol version, and the server extension version is atleast that of the client.

- **Introduce analyze options & add structure to GRPC row answers (#235)**

## Bugs Fixed


## Code Refactors


## Other Improvements

