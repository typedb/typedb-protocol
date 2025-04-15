Documentation: https://typedb.com/docs/drivers/

### Distribution

#### For Rust through crates.io

Available from https://crates.io/crates/typedb-protocol

```sh
cargo add typedb-protocol@3.2.0-rc0
```

#### For Node.js through npm

Available from https://www.npmjs.com/package/typedb-protocol

```sh
npm install typedb-protocol@3.2.0-rc0
```
or
```sh
yarn add typedb-protocol@3.2.0-rc0
```


## New Features
- **Add sign-in request for authentication token retrieval**
  A new mechanism of authentication tokens has been introduced to replace the old way of sending usernames and passwords through the network with every request.
  
  Instead, all user credentials (currently, it's usernames and passwords) are sent only:
  * as a part of `connection_open` request for authentication and authorization, with a temporary token returned;
  * as a part of `sign_in` request for sign ins within an established connection (to change the user or to get a new authentication token).
  Then, all further requests are expected to be authenticated only by temporary, less sensitive tokens. 
  
  The approach is extensible to other credential types that can be introduced in the future.
  
  

## Bugs Fixed


## Code Refactors


## Other Improvements

    
