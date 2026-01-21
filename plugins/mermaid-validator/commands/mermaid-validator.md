---
description: Validate Mermaid diagram syntax using official mermaid-cli
argument-hint: [diagram-code or file-path]
allowed-tools: [Bash, Read, Write]
---

# Mermaid Validator Command

Validate Mermaid diagram syntax using the official mermaid-cli (mmdc).

## Arguments

$ARGUMENTS

## Instructions

1. **Check if mmdc is available**:
   ```bash
   npx -p @mermaid-js/mermaid-cli mmdc --version
   ```

2. **Get diagram code**:
   - If argument is a file path, read the file
   - If argument is diagram code, use it directly
   - If no argument, ask user to provide diagram code

3. **Write to temp file and validate**:
   ```bash
   cat << 'EOF' > /tmp/diagram.mmd
   [diagram code here]
   EOF
   npx -p @mermaid-js/mermaid-cli mmdc -i /tmp/diagram.mmd -o /tmp/diagram.svg 2>&1
   ```

4. **Report result**:
   - Success: Show validated diagram code
   - Error: Show error details and suggest fixes

5. **Cleanup**:
   ```bash
   rm -f /tmp/diagram.mmd /tmp/diagram.svg
   ```

## Output Format

```
## Mermaid Validation Result

**Status**: ✅ Success / ❌ Error

### Diagram Code
\`\`\`mermaid
[validated code]
\`\`\`

### Error Details (if applicable)
- Line: X
- Error: [message]
- Fix: [suggestion]
```

## Common Fixes

| Error | Fix |
|-------|-----|
| Arrow syntax | Use `-->` not `->` in flowcharts |
| Special chars | Wrap in quotes: `A["Value: 100"]` |
| Missing end | Add `end` after subgraph/loop blocks |
| Unknown type | Check keyword: `flowchart`, `sequenceDiagram`, `classDiagram` |
