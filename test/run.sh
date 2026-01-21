#!/bin/bash

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
