#!/bin/bash

# TODO: This test file is placed outside plugins/ to exclude from plugin distribution.
# Claude Code copies entire plugin directory to cache, so test files must be external.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VALIDATOR="$SCRIPT_DIR/../plugins/mermaid-validator/scripts/validate.sh"

echo "=== File input ==="
echo 'flowchart TD
    A --> B' > /tmp/test.mmd
bash "$VALIDATOR" /tmp/test.mmd
rm /tmp/test.mmd

echo ""
echo "=== Stdin input ==="
echo 'sequenceDiagram
    A->>B: Hello' | bash "$VALIDATOR"
