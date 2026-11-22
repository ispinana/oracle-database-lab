#!/usr/bin/env bash
set -euo pipefail
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
echo "$JAVA_HOME"
java -version
"$HOME/oracle/sqlcl/bin/sql" -version
