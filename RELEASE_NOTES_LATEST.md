# TypeDB Protocol

This version extends the network API with exciting new features like value variables and querying with annotations more generally in concepts' APIs.

Documentation: https://docs.vaticle.com/docs/client-api/

### Distribution

#### For Java through Maven

Available from https://repo.vaticle.com
```xml
<repositories>
    <repository>
        <id>repo.vaticle.com</id>
        <url>https://repo.vaticle.com/repository/maven/</url>
    </repository>
</repositories>
<dependencies>
    <dependency>
        <groupid>com.vaticle.typedb</groupid>
        <artifactid>typedb-protocol</artifactid>
        <version>{version}</version>
    </dependency>
</dependencies>
```

#### For Python through PyPI

Available from https://pypi.org/project/typedb-protocol/

```sh
pip install typedb-protocol
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
- **Add protocol versioning transmitted during connection open**
  
  We add a new connection opening request, which allows transmitting the protocol version for the server to verify.
  
  As this is the first versioned protocol, we set the version number to version 1.
  
  Previous versions are assumed to be version < 1, and can be considered 0 for now.
  
  
- **Introduce value query answers**
  
  Implement protocol required to return 'Value' answers in as part of the responses from `match` queries. To support this we generalise some of the message definitions used to transmit attribute values and value types.
  
  
- **Introduce message types to encode annotations**
  
  We replace usages of `boolean` for key arguments with a message type called `Annotation` - this gives us a natural place to extend the set/capabilities of the annotations in the future. The new message type is used to implement the new "unique" annotation.
  
  

## Bugs Fixed


## Code Refactors


## Other Improvements
- **Update release notes workflow**
  
  We integrate the new release notes tooling. The release notes are now to be written by a person and committed to the repo.
  
  
- **Make Concept.value.value_type use consistent underscoring**

- **Annotation serialisation uses specialised message types**

    
