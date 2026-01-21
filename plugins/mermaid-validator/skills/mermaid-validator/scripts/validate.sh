#!/bin/bash

# Mermaid diagram syntax validator
# Uses mermaid-ast for pure static analysis (no browser required)
# Usage: ./validate.sh <file.mmd>
#        cat diagram.mmd | ./validate.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
INPUT_FILE="${1:--}"

node --input-type=module -e "
import { readFileSync } from 'fs';
import { parse } from '$PLUGIN_ROOT/bin/mermaid-ast.mjs';

const file = process.argv[1];
let input;

if (file && file !== '-') {
  input = readFileSync(file, 'utf8');
} else {
  input = readFileSync('/dev/stdin', 'utf8');
}

try {
  const ast = parse(input.trim());
  console.log('✅ Valid -', ast.type);
  process.exit(0);
} catch (e) {
  console.log('❌ Invalid');
  console.log(e.message);
  process.exit(1);
}
" -- "$INPUT_FILE"
