#!/bin/bash

# Mermaid diagram syntax validator
# Uses mermaid-ast for pure static analysis (no browser required)
# Usage: ./validate.sh <file.mmd>
#        cat diagram.mmd | ./validate.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CACHE_DIR="${TMPDIR:-/tmp}/mermaid-ast-cache"

# Setup cache directory with mermaid-ast if not exists
if [ ! -d "$CACHE_DIR/node_modules/mermaid-ast" ]; then
  mkdir -p "$CACHE_DIR"
  cd "$CACHE_DIR"
  npm init -y > /dev/null 2>&1
  npm install --silent mermaid-ast 2>/dev/null
fi

# Run validation
cd "$CACHE_DIR"
if [ -n "$1" ] && [ "$1" != "-" ]; then
  node --input-type=module -e "
import { parse } from 'mermaid-ast';
import { readFileSync } from 'fs';
const input = readFileSync('$1', 'utf8');
try {
  const ast = parse(input.trim());
  console.log('✅ Valid -', ast.type);
  process.exit(0);
} catch (e) {
  console.log('❌ Invalid');
  console.log(e.message);
  process.exit(1);
}
"
else
  node --input-type=module -e "
import { parse } from 'mermaid-ast';
import { readFileSync } from 'fs';
const input = readFileSync('/dev/stdin', 'utf8');
try {
  const ast = parse(input.trim());
  console.log('✅ Valid -', ast.type);
  process.exit(0);
} catch (e) {
  console.log('❌ Invalid');
  console.log(e.message);
  process.exit(1);
}
"
fi
