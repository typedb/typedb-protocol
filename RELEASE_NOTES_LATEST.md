Documentation: https://typedb.com/docs/drivers/

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol@3.10.0
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
npm install typedb-protocol@3.10.0
```
or
```sh
yarn add typedb-protocol@3.10.0
```


## New Features


## Bugs Fixed


## Code Refactors


## Other Improvements
- **Bazel 8 upgrade**

  Update Bazel version from 6.2 to 8.5.1.

  The upgrade is done in a backwards-compatible way, such that "upstream" repositories that are yet to be upgraded may depend on this repository. This is done by preserving WORKSPACE and the deps.bzl loader files alongside the new Bazel 8 ones. Once every repository has been upgraded to Bazel 8, these files will be removed.
