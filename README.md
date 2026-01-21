# Mermaid Validator Plugin

A Claude Code plugin for creating and validating Mermaid diagrams using the official mermaid-cli (mmdc) tool.

## Features

- Create syntactically correct Mermaid diagrams
- Validate diagrams using official mermaid-cli
- Fix common syntax errors
- Support for all major diagram types

## Plugin Structure

```
mermaid-skill/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   └── mermaid-validator/
│       ├── SKILL.md
│       └── references/
│           └── REFERENCE.md
└── README.md
```

## Supported Diagram Types

| Type | Keyword | Use Case |
|------|---------|----------|
| Flowchart | `flowchart TD` | Process flows, decision trees |
| Sequence | `sequenceDiagram` | API interactions, message flows |
| Class | `classDiagram` | OOP structures, relationships |
| State | `stateDiagram-v2` | State machines, transitions |
| ER | `erDiagram` | Database schemas |
| Gantt | `gantt` | Project schedules |
| Pie | `pie` | Data distribution |

## Prerequisites

Node.js and npm are required for mermaid-cli:

```bash
# Use npx (no install needed)
npx -p @mermaid-js/mermaid-cli mmdc --version

# Or install globally
npm install -g @mermaid-js/mermaid-cli
```

## Installation

Add this plugin to Claude Code:

```bash
claude plugins install /path/to/mermaid-skill
```

## Usage

The skill activates automatically when:

- Creating Mermaid diagrams
- Debugging rendering issues
- Documenting system architecture with diagrams

### Example Prompts

```
Create a flowchart for user authentication
```

```
This Mermaid diagram isn't rendering - can you fix it?
```

```
Create a sequence diagram showing the API flow between client and server
```

## Validation Process

1. Write Mermaid code to a temp file (`/tmp/diagram.mmd`)
2. Run `mmdc` to validate syntax
3. Report success or identify errors with fix suggestions
4. Clean up temp files

## License

MIT
