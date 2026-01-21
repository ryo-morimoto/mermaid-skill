---
description: Validate Mermaid diagram syntax using mermaid-ast (no browser required)
allowed-tools:
  - Bash
  - Read
  - Write
---

## Context

- User argument: $ARGUMENTS

## Task

Validate the provided Mermaid diagram using mermaid-ast (pure static analysis, no browser).

1. If `$ARGUMENTS` is a file path, validate directly: `node ${CLAUDE_PLUGIN_ROOT}/dist/validate.mjs <file>`
2. If `$ARGUMENTS` is diagram code, pipe to validator: `echo '<code>' | node ${CLAUDE_PLUGIN_ROOT}/dist/validate.mjs`
3. If empty, ask user for diagram code
4. Report result with fix suggestions

## Common Errors

| Error | Fix |
|-------|-----|
| Arrow syntax | Use `-->` not `->` in flowcharts |
| Special chars | Wrap in quotes: `A["Value: 100"]` |
| Missing end | Add `end` after subgraph/loop blocks |
