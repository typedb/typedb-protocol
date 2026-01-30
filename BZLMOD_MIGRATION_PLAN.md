# TypeDB Protocol: Bazel 6 to 8 Migration Plan

## Overview

Migrate `typedb-protocol` from WORKSPACE-based builds to Bzlmod (MODULE.bazel) for Bazel 8 compatibility.

**Current Status:** ~90% migrated, but build fails due to TypeScript toolchain issue

---

## Current State

| Aspect | Status |
|--------|--------|
| Bazel Version | 8.0.0 |
| MODULE.bazel | Exists (115 lines) |
| WORKSPACE | Deprecated, still present |
| Build Status | Fails - `@npm_typescript` not visible |

### What's Already Migrated

1. **Core BCR dependencies** - All `bazel_dep()` declarations in place
2. **Proto/gRPC rules** - `protobuf`, `grpc`, `rules_proto_grpc` configured
3. **Rust toolchain** - `rules_rust` with crate_universe extension
4. **Python toolchain** - `rules_python` with 3.11 toolchain
5. **Maven dependencies** - `rules_jvm_external` extension configured
6. **Local path overrides** - `typedb_dependencies` and `typedb_bazel_distribution`
7. **Node.js toolchain** - `rules_nodejs` configured
8. **NPM dependencies** - `aspect_rules_js` npm extension configured

### What's Broken

**TypeScript Toolchain Issue:**
```
ERROR: no such package '@@[unknown repo 'npm_typescript' requested from @@]//':
The repository '@@[unknown repo 'npm_typescript' requested from @@]' could not be resolved
```

The `ts_project` rule with `transpiler = "tsc"` requires `@npm_typescript` repository, which isn't properly exposed in Bzlmod mode.

---

## Migration Steps

### Step 1: Fix TypeScript Toolchain (Critical)

The `aspect_rules_ts` extension needs proper TypeScript dependency configuration.

**Option A: Use rules_ts extension for TypeScript version**

Add to MODULE.bazel:
```python
# TypeScript toolchain setup
rules_ts = use_extension("@aspect_rules_ts//ts:extensions.bzl", "ext")
rules_ts.deps(
    ts_version_from = "//grpc/nodejs:package.json",
)
use_repo(rules_ts, "npm_typescript")
```

**Option B: Reference TypeScript from npm workspace**

Modify `grpc/nodejs/BUILD` to use local node_modules typescript:
```python
ts_project(
    name = "typedb-protocol",
    ...
    deps = [
        ":node_modules/typescript",  # Already in deps
        ...
    ],
    transpiler = "tsc",
)
```

And ensure `typescript` is in the npm dependencies and properly linked.

### Step 2: Verify All Targets Build

After fixing TypeScript, run:
```bash
bazelisk build //...
```

Expected targets (42 total):
- `//proto:*` - 16 proto_library targets
- `//grpc/java:*` - Java gRPC library
- `//grpc/rust:*` - Rust tonic library + crate assembly
- `//grpc/nodejs:*` - TypeScript gRPC library + npm package
- `//tool/release:*` - Release deployment targets
- Checkstyle tests

### Step 3: Remove Deprecated Files

Once build passes, remove:

1. **WORKSPACE file** - No longer needed
   ```bash
   rm WORKSPACE
   ```

2. **dependencies/typedb/repositories.bzl** - Only used in WORKSPACE mode
   ```bash
   rm dependencies/typedb/repositories.bzl
   ```

3. **Update .bazelrc** - Remove WORKSPACE compatibility comment
   ```bash
   # Remove these lines:
   # WORKSPACE is kept for backward compatibility but is deprecated
   # To use WORKSPACE mode, uncomment the following line:
   # common --enable_workspace=true
   ```

### Step 4: Align Dependency Versions

Ensure version alignment with `typedb_dependencies`:

| Dependency | typedb-protocol | typedb_dependencies | Action |
|------------|-----------------|---------------------|--------|
| gRPC (Java) | 1.49.0 | 1.50.1 | Update to 1.50.1 |
| protobuf-java | 3.21.7 | (check) | Verify alignment |
| guava | 30.1-jre | (check) | Verify alignment |

Update MODULE.bazel maven artifacts:
```python
maven.install(
    artifacts = [
        "com.google.guava:guava:30.1-jre",
        "com.google.protobuf:protobuf-java:3.21.7",
        "io.grpc:grpc-api:1.50.1",      # Updated
        "io.grpc:grpc-core:1.50.1",     # Updated
        "io.grpc:grpc-protobuf:1.50.1", # Updated
        "io.grpc:grpc-stub:1.50.1",     # Updated
        "javax.annotation:javax.annotation-api:1.3.2",
    ],
    ...
)
```

### Step 5: Update MODULE.bazel.lock

After any MODULE.bazel changes:
```bash
bazelisk mod deps --lockfile_mode=update
```

Or delete and regenerate:
```bash
rm MODULE.bazel.lock
bazelisk build //...  # Regenerates lock file
```

### Step 6: Document Migration Status

Create/update `BZLMOD_MIGRATION_STATUS.md` with:
- Build verification command
- Known issues or exclusions
- Environment requirements

---

## Verification Commands

```bash
# Full build
cd /opt/project/repositories/typedb-protocol
bazelisk build //...

# Test specific components
bazelisk build //proto/...           # Proto libraries
bazelisk build //grpc/java/...       # Java gRPC
bazelisk build //grpc/rust/...       # Rust tonic
bazelisk build //grpc/nodejs/...     # TypeScript gRPC
```

---

## Dependencies Graph

```
typedb-protocol
├── typedb_dependencies (local_path_override)
│   └── typedb_bazel_distribution (transitive)
├── BCR modules
│   ├── protobuf (29.3)
│   ├── grpc (1.69.0)
│   ├── rules_proto_grpc (5.0.1)
│   ├── rules_rust (0.56.0)
│   ├── rules_python (1.0.0)
│   ├── aspect_rules_js (2.1.2)
│   └── aspect_rules_ts (3.4.0)
└── Maven artifacts
    ├── io.grpc:grpc-* (1.49.0 → 1.50.1)
    ├── com.google.protobuf:protobuf-java
    └── com.google.guava:guava
```

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| TypeScript build breaks | High | Medium | Fix npm_typescript exposure |
| Version conflicts | Medium | Medium | Align with typedb_dependencies |
| CI/CD breaks | Medium | High | Test in CI before merging |
| Rust crate issues | Low | Medium | Already working via extension |

---

## Files to Modify

| File | Action |
|------|--------|
| `MODULE.bazel` | Add rules_ts extension, update gRPC versions |
| `WORKSPACE` | Delete after migration complete |
| `dependencies/typedb/repositories.bzl` | Delete after migration complete |
| `.bazelrc` | Remove WORKSPACE compatibility comments |
| `MODULE.bazel.lock` | Regenerate after changes |
| `BZLMOD_MIGRATION_STATUS.md` | Create with final status |

---

## Rollback Plan

If migration fails, re-enable WORKSPACE mode:
```bash
# Add to .bazelrc
common --enable_workspace=true
```

This allows builds to continue while issues are resolved.

---

## Reference

- [Bzlmod Migration Guide](https://bazel.build/external/migration)
- [aspect_rules_ts Bzlmod](https://github.com/aspect-build/rules_ts/blob/main/docs/bzlmod.md)
- [rules_jvm_external Bzlmod](https://github.com/bazelbuild/rules_jvm_external#bzlmod)
- [Dependencies repo BZLMOD_MIGRATION_GUIDE.md](../dependencies/BZLMOD_MIGRATION_GUIDE.md)
