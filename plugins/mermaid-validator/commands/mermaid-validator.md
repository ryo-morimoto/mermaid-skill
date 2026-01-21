---
description: Validate Mermaid diagram syntax using mermaid-ast (no browser required)
allowed-tools:
  - Bash(bash:*)
  - Bash(cat:*)
  - Bash(rm:*)
  - Read
  - Write
---

## Context

- User argument: $ARGUMENTS

## Task

Validate the provided Mermaid diagram using mermaid-ast (pure static analysis, no browser).

1. If `$ARGUMENTS` is a file path, read the file content
2. If `$ARGUMENTS` is diagram code or empty, ask user for diagram code
3. Write diagram to `/tmp/diagram.mmd`
4. Run validation: `bash ${CLAUDE_PLUGIN_ROOT}/skills/mermaid-validator/scripts/validate.sh /tmp/diagram.mmd`
5. Report result with fix suggestions
6. Cleanup: `rm -f /tmp/diagram.mmd`

## Common Errors

| Error | Fix |
|-------|-----|
| Arrow syntax | Use `-->` not `->` in flowcharts |
| Special chars | Wrap in quotes: `A["Value: 100"]` |
| Missing end | Add `end` after subgraph/loop blocks |
