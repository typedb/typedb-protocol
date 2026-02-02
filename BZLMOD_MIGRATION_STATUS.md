# TypeDB Protocol: Bzlmod Migration Status

**Status: COMPLETE**

All 42 targets build successfully with Bazel 8.0.0 using Bzlmod.

## Build Verification

```bash
bazelisk build //...
```

**Results:**
- 42 targets analyzed
- All targets build successfully
- No exclusions required

## Targets

| Target | Status |
|--------|--------|
| `//proto/...` | ✅ 16 proto_library targets |
| `//grpc/java:typedb-protocol` | ✅ Java gRPC library |
| `//grpc/rust:typedb_protocol` | ✅ Rust tonic library |
| `//grpc/rust:assemble_crate` | ✅ Crate assembly |
| `//grpc/rust:deploy_crate` | ✅ Crate deployment |
| `//grpc/nodejs:typedb-protocol` | ✅ TypeScript gRPC library |
| `//grpc/nodejs:typedb-protocol-package` | ✅ NPM package |
| `//grpc/nodejs:assemble-npm` | ✅ NPM assembly |
| `//grpc/nodejs:deploy-npm` | ✅ NPM deployment |
| `//tool/release/...` | ✅ Release targets |
| Checkstyle tests | ✅ All pass |

## Configuration

### MODULE.bazel

Key configurations:
- **Bazel modules**: protobuf 29.3, grpc 1.69.0, rules_proto_grpc 5.0.1
- **Rust**: 1.81.0 via rules_rust with isolated crate extension
- **Node.js**: 17.9.1 via rules_nodejs
- **TypeScript**: 4.9.5 via aspect_rules_ts
- **Python**: 3.11 toolchain
- **Maven**: protocol-specific artifacts in `protocol_maven` repo

### Local Path Overrides

```python
local_path_override(module_name = "typedb_dependencies", path = "../dependencies")
local_path_override(module_name = "typedb_bazel_distribution", path = "../bazel-distribution")
```

### Experimental Flags

`.bazelrc` includes:
```
common --experimental_isolated_extension_usages
```

This is required to avoid crate universe conflicts between typedb-protocol and typedb_dependencies, both of which define crate extensions.

## Dependencies

```
typedb-protocol
├── typedb_dependencies (local)
│   └── typedb_bazel_distribution (local, transitive)
├── BCR modules
│   ├── protobuf (29.3)
│   ├── grpc (1.69.0)
│   ├── rules_proto_grpc (5.0.1)
│   ├── rules_rust (0.56.0)
│   ├── rules_python (1.0.0)
│   ├── aspect_rules_js (2.1.2)
│   └── aspect_rules_ts (3.4.0)
└── Maven (protocol_maven)
    ├── io.grpc:grpc-* (1.50.1)
    ├── com.google.protobuf:protobuf-java
    └── com.google.guava:guava
```

## Migration Notes

1. **Crate Extension Isolation**: The crate extension uses `isolate = True` because both typedb-protocol and typedb_dependencies define crate extensions with the same name. This requires `--experimental_isolated_extension_usages` flag.

2. **TypeScript Toolchain**: The `rules_ts` extension is configured to read the TypeScript version from `//grpc/nodejs:package.json`, which exposes `@npm_typescript` for the `ts_project` transpiler.

3. **Maven Dependencies**: Protocol-specific Maven artifacts are in `protocol_maven` repo, separate from the larger `maven` repo in typedb_dependencies.

## Files

| File | Purpose |
|------|---------|
| `MODULE.bazel` | Bzlmod configuration |
| `MODULE.bazel.lock` | Dependency lock file |
| `.bazelrc` | Build flags including experimental flags |
| `WORKSPACE` | Deprecated, kept for backward compatibility |

## Cleanup (Optional)

Once all consumers have migrated to Bzlmod, these can be removed:
- `WORKSPACE`
- `dependencies/typedb/repositories.bzl`
- WORKSPACE compatibility comments in `.bazelrc`
