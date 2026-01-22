# Mermaid Validator Plugin

A Claude Code plugin for validating Mermaid diagram syntax using mermaid-ast (pure static analysis, no browser required).

## Features

- Validate Mermaid diagram syntax
- Pure static analysis (no browser/Puppeteer)
- Fast validation with detailed error messages
- Support for all 18 diagram types

## Plugin Structure

```
mermaid-claude-plugins/
├── package.json                    # Build & test scripts
├── src/
│   ├── validate.ts                 # Validator source
│   └── validate.test.ts            # Tests
└── plugins/
    ├── dist/validate.mjs           # Bundled validator (node)
    └── mermaid-validator/
        ├── dist -> ../dist         # Symlink (resolved on install)
        ├── commands/               # Slash commands
        ├── skills/                 # Skill definitions
        └── .claude-plugin/
            └── plugin.json
```

## Supported Diagram Types

flowchart, sequence, class, state, erDiagram, gantt, gitGraph, mindmap, journey, kanban, pie, timeline, sankey, quadrant, requirement, xychart, c4, block

## Prerequisites

Node.js is required to run the validation script.

## Installation

Add this marketplace and install the plugin:

```bash
/plugin marketplace add ryo-morimoto/mermaid-claude-plugins
/plugin install mermaid-validator@ryo-morimoto-mermaid-claude-plugins
```

## Usage

The skill activates automatically when:

- Creating Mermaid diagrams
- Debugging rendering issues
- Documenting system architecture with diagrams

### Slash Command

```
/mermaid-validator <diagram or file path>
```

### Example Prompts

```
Create a flowchart for user authentication
```

```
This Mermaid diagram isn't rendering - can you fix it?
```

## Validation Process

1. Write Mermaid code to a temp file
2. Run `validate.sh` (uses mermaid-ast for static analysis)
3. Report success or identify errors with fix suggestions
4. Clean up temp files

## Development

```bash
# Install dependencies
bun install

# Build mermaid-ast bundle
bun run build

# Run tests
bun test
```

## License

MIT
