#!/bin/sh
set -eu

JABFA_ROOT=${JABFA_ROOT:-"$HOME/Work/jabfa"}
JABFA_BIN=${JABFA_BIN:-"$JABFA_ROOT/target/release"}
BRAIN_VAULT=${BRAIN_VAULT:-"$HOME/Documents/llm-brain"}
JABFA_DATABASE=${JABFA_DATABASE:-"${XDG_RUNTIME_DIR:-/tmp}/llm-brain-jabfa.sqlite3"}

# Refresh only the derived index before each MCP session. Source notes are read-only.
"$JABFA_BIN/jabfa" index "$BRAIN_VAULT" --database "$JABFA_DATABASE" >/dev/null
exec "$JABFA_BIN/jabfa-mcp" --vault "$BRAIN_VAULT" --database "$JABFA_DATABASE"
