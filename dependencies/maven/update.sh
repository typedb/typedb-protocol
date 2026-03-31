#!/usr/bin/env sh
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

MAVEN_REPO="${MAVEN_REPO:-protocol_maven}"
SNAPSHOT_FILE="dependencies/maven/artifacts.snapshot"

echo "-------------------------"
echo "Regenerating '$SNAPSHOT_FILE' from @${MAVEN_REPO}..."

OUTPUT=$(bazel query "kind(alias, @${MAVEN_REPO}//...)" 2>/dev/null | sort)
if [ $? -ne 0 ]; then
    echo "ERROR: bazel query failed" >&2
    exit 1
fi

echo "$OUTPUT" > "$SNAPSHOT_FILE"

ADDED=$(echo "$OUTPUT" | wc -l | tr -d ' ')
echo "DONE! '$SNAPSHOT_FILE' updated with $ADDED entries."
echo "-------------------------"
