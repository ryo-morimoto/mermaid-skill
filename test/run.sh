#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
VALIDATOR="$PROJECT_ROOT/plugins/mermaid-validator/skills/mermaid-validator/scripts/validate.sh"

PASS=0
FAIL=0

test_valid() {
  local file="$1"
  local name="$(basename "$file")"
  if bash "$VALIDATOR" "$file" > /dev/null 2>&1; then
    echo "✅ $name"
    ((PASS++))
  else
    echo "❌ $name (expected valid)"
    ((FAIL++))
  fi
}

test_invalid() {
  local file="$1"
  local name="$(basename "$file")"
  if bash "$VALIDATOR" "$file" > /dev/null 2>&1; then
    echo "❌ $name (expected invalid)"
    ((FAIL++))
  else
    echo "✅ $name"
    ((PASS++))
  fi
}

echo "=== Valid diagrams ==="
for f in "$SCRIPT_DIR/fixtures/valid-"*.mmd; do
  test_valid "$f"
done

echo ""
echo "=== Invalid diagrams ==="
for f in "$SCRIPT_DIR/fixtures/invalid-"*.mmd; do
  test_invalid "$f"
done

echo ""
echo "=== Results ==="
echo "Pass: $PASS, Fail: $FAIL"

[ "$FAIL" -eq 0 ]
