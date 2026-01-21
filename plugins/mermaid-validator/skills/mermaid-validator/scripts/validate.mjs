#!/usr/bin/env node

/**
 * Mermaid diagram syntax validator using mermaid-ast
 * Usage: node validate.mjs <file.mmd>
 *        cat diagram.mmd | node validate.mjs
 */

import { readFileSync } from 'fs';

async function main() {
  // Dynamic import to handle missing dependency gracefully
  let parse;
  try {
    const mod = await import('mermaid-ast');
    parse = mod.parse;
  } catch {
    console.error('Error: mermaid-ast not installed.');
    console.error('Run: npm install mermaid-ast');
    process.exit(2);
  }

  // Read input from file or stdin
  let input;
  const file = process.argv[2];

  if (file && file !== '-') {
    try {
      input = readFileSync(file, 'utf8');
    } catch (e) {
      console.error(`Error: Cannot read file: ${file}`);
      process.exit(2);
    }
  } else {
    input = readFileSync('/dev/stdin', 'utf8');
  }

  // Validate
  try {
    const ast = parse(input.trim());
    console.log(`✅ Valid - ${ast.type}`);
    process.exit(0);
  } catch (e) {
    console.log('❌ Invalid');
    console.log(e.message);
    process.exit(1);
  }
}

main();
