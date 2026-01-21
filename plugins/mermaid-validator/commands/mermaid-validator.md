---
description: Validate Mermaid diagram syntax using official mermaid-cli
allowed-tools:
  - Bash(npx:*)
  - Bash(cat:*)
  - Bash(rm:*)
  - Read
  - Write
---

## Context

- mmdc version: !`npx -p @mermaid-js/mermaid-cli mmdc --version 2>&1 | head -1`
- User argument: $ARGUMENTS

## Task

Validate the provided Mermaid diagram using mermaid-cli.

1. If `$ARGUMENTS` is a file path, read the file content
2. If `$ARGUMENTS` is diagram code or empty, ask user for diagram code
3. Write diagram to `/tmp/diagram.mmd`
4. Run validation: `npx -p @mermaid-js/mermaid-cli mmdc -i /tmp/diagram.mmd -o - > /dev/null 2>&1 && echo "✅ Valid" || echo "❌ Invalid"`
5. If invalid, run again to get error: `npx -p @mermaid-js/mermaid-cli mmdc -i /tmp/diagram.mmd -o - 2>&1`
6. Report result with fix suggestions
7. Cleanup: `rm -f /tmp/diagram.mmd`

## Common Errors

| Error | Fix |
|-------|-----|
| Arrow syntax | Use `-->` not `->` in flowcharts |
| Special chars | Wrap in quotes: `A["Value: 100"]` |
| Missing end | Add `end` after subgraph/loop blocks |
