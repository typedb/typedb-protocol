Documentation: https://typedb.com/docs/drivers/

**This is an alpha release for CLUSTERED TypeDB 3.x. Do not use this as a stable version of TypeDB.**
**Instead, reference a non-alpha release of the same major and minor versions.**

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
<<<<<<< HEAD
cargo add typedb-protocol@3.10.0
=======
cargo add typedb-protocol@3.7.0-alpha-0
>>>>>>> 351ff32 (Update version to 3.0.7-alpha-0 with release notes)
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
<<<<<<< HEAD
npm install typedb-protocol@3.10.0
```
or
```sh
yarn add typedb-protocol@3.10.0
=======
npm install typedb-protocol@3.7.0-alpha-0
```
or
```sh
yarn add typedb-protocol@3.7.0-alpha-0
>>>>>>> 351ff32 (Update version to 3.0.7-alpha-0 with release notes)
```


## New Features
<<<<<<< HEAD

=======
- **Introduce Raft and clustering protocols for TypeDB Cluster**
  
>>>>>>> 351ff32 (Update version to 3.0.7-alpha-0 with release notes)

## Bugs Fixed


## Code Refactors


## Other Improvements
<<<<<<< HEAD
- **Bazel 8 upgrade**
  
  Update Bazel version from 6.2 to 8.5.1.
  
  The upgrade is done in a backwards-compatible way, such that "upstream" repositories that are yet to be upgraded may depend on this repository. This is done by preserving WORKSPACE and the deps.bzl loader files alongside the new Bazel 8 ones. Once every repository has been upgraded to Bazel 8, these files will be removed.
  
  
    
=======
>>>>>>> 351ff32 (Update version to 3.0.7-alpha-0 with release notes)
