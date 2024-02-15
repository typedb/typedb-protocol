Documentation: https://typedb.com/docs/clients/2.x/clients

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol@2.26.6
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
npm install typedb-protocol@2.26.6
```
or
```sh
yarn add typedb-protocol@2.26.6
```


## New Features


## Bugs Fixed


## Code Refactors


## Other Improvements
- **Explicitly install python tool dependencies**
  
  Since the upgrade to rules-python v0.24 (https://github.com/vaticle/dependencies/pull/460), we are required to explicitly install python dependencies in the WORKSPACE file. The python tools happened to be unused, so these errors were not visible until the sync dependencies tool was restored.
  
- **Sync dependencies in CI**
  
  We add a sync-dependencies job to be run in CI after successful snapshot and release deployments. The job sends a request to vaticle-bot to update all downstream dependencies.
  
  Note: this PR does _not_ update the `dependencies` repo dependency. It will be updated automatically by the bot during its first pass.
  
- **Set up CI filters for master-development workflow**

- **Migrate artifact hosting to cloudsmith**
  Updates artifact deployment & consumption rules to use cloudsmith instead of the self-hosted sonatype repository.
  
  
- **Update grpc dependency labels**
  
  We update all references to `@vaticle_dependencies//builder/grpc` to refer to `@vaticle_dependencies//builder/proto_grpc` instead. See https://github.com/vaticle/dependencies/pull/492.
  
- **Simplify github templates**

    
