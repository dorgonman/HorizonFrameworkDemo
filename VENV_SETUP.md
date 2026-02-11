# Virtual Environment Setup for HorizonFrameworkDemo

## Overview

This project uses a local Python virtual environment (venv) to manage dependencies for the kano-agent-backlog-skill.

## Quick Start

### Activate Virtual Environment

**Windows:**
```bash
.venv\Scripts\activate
```

**macOS/Linux:**
```bash
source .venv/bin/activate
```

### Verify Installation

```bash
kano-backlog --version
kano-backlog doctor
```

## Project Structure

```
HorizonFrameworkDemo/
├── .venv/                          # Virtual environment (local)
├── skills/
│   └── kano-agent-backlog-skill/   # Submodule (editable install)
├── _kano/
│   └── backlog/
│       └── products/
│           └── HorizonFrameworkDemo/  # Backlog data
├── .kano/
│   └── backlog_config.toml         # Configuration
└── activate-venv.bat               # Windows activation helper
```

## Common Commands

### Create Work Items

```bash
# Create a task
kano-backlog item create --type task \
  --title "Your task title" \
  --product HorizonFrameworkDemo \
  --agent kiro

# Create a feature
kano-backlog item create --type feature \
  --title "Your feature title" \
  --product HorizonFrameworkDemo \
  --agent kiro
```

### Manage Work Items

```bash
# Read an item
kano-backlog item read HR-TSK-0001

# Update state
kano-backlog item update-state HR-TSK-0001 \
  --state Ready \
  --agent kiro \
  --product HorizonFrameworkDemo

# Check Ready gate
kano-backlog item check-ready HR-TSK-0001
```

### View Backlog

```bash
# Generate views
kano-backlog view refresh --product HorizonFrameworkDemo

# Check environment
kano-backlog doctor
```

## Installation Details

The venv was created with:

```bash
# Create virtual environment
python -m venv .venv

# Upgrade pip
.venv/Scripts/python -m pip install --upgrade pip setuptools wheel

# Install kano-agent-backlog-skill in editable mode
.venv/Scripts/python -m pip install -e "skills/kano-agent-backlog-skill[dev]"
```

## Troubleshooting

### "kano-backlog: command not found"

Make sure the virtual environment is activated:

```bash
# Windows
.venv\Scripts\activate

# macOS/Linux
source .venv/bin/activate
```

### Reinstall Dependencies

```bash
.venv/Scripts/python -m pip install -e "skills/kano-agent-backlog-skill[dev]"
```

### Reset Virtual Environment

```bash
# Remove old venv
rm -r .venv

# Create new venv
python -m venv .venv

# Activate and install
.venv/Scripts/activate
pip install -e "skills/kano-agent-backlog-skill[dev]"
```

## Environment Status

- **Python Version:** 3.14.2
- **kano-backlog Version:** 0.1.0
- **Product:** HorizonFrameworkDemo
- **Prefix:** HR
- **Status:** ✅ All checks passed

## Next Steps

1. Activate the virtual environment
2. Create your first work item
3. Fill in required fields (Context, Goal, Approach, Acceptance Criteria, Risks)
4. Move items through the workflow (Proposed → Planned → Ready → InProgress → Done)
5. Record decisions in Architecture Decision Records (ADRs)

For more information, see:
- `skills/kano-agent-backlog-skill/docs/agent-quick-start.md`
- `skills/kano-agent-backlog-skill/README.md`
- `skills/kano-agent-backlog-skill/SKILL.md`
