# claude-code-setup-from-ecc

A curated Claude Code setup script based on [everything-claude-code](https://github.com/affaan-m/everything-claude-code). Pulls agents, commands, skills, rules, hooks, contexts and MCP servers — ready to install.

## Prerequisites

- [Claude Code](https://claude.ai/code) installed
- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) cloned locally
- Node.js + npx available

## What Gets Installed

| Category | Count | Notes |
|----------|-------|-------|
| Rules | 9 | `common/` only — language-agnostic |
| Agents | 11 | No Go-specific agents |
| Commands | 19 | Includes multi/parallel commands |
| Skills | 22 | Language-agnostic only |
| Hooks | 1 | `hooks.json` |
| Contexts | 3 | `dev`, `research`, `review` |
| MCP Servers | 9 | See list below |

### Agents
`planner` · `architect` · `code-reviewer` · `security-reviewer` · `tdd-guide` · `build-error-resolver` · `refactor-cleaner` · `doc-updater` · `database-reviewer` · `e2e-runner` · `chief-of-staff`

### Slash Commands
`/plan` · `/tdd` · `/code-review` · `/build-fix` · `/refactor-clean` · `/learn` · `/checkpoint` · `/verify` · `/e2e` · `/eval` · `/orchestrate` · `/quality-gate` · `/update-docs` · `/test-coverage` · `/multi-plan` · `/multi-backend` · `/multi-frontend` · `/multi-execute` · `/multi-workflow`

### Skills
`coding-standards` · `backend-patterns` · `frontend-patterns` · `api-design` · `tdd-workflow` · `e2e-testing` · `database-migrations` · `deployment-patterns` · `docker-patterns` · `security-review` · `security-scan` · `ai-first-engineering` · `agentic-engineering` · `autonomous-loops` · `iterative-retrieval` · `cost-aware-llm-pipeline` · `eval-harness` · `verification-loop` · `continuous-learning` · `continuous-learning-v2` · `strategic-compact` · `search-first`

### MCP Servers
| Server | Type | Requires |
|--------|------|----------|
| memory | npx | — |
| sequential-thinking | npx | — |
| context7 | npx | — |
| filesystem | npx | — |
| github | npx | `GITHUB_PERSONAL_ACCESS_TOKEN` |
| vercel | http | — |
| supabase | npx | `SUPABASE_PROJECT_REF` |
| magic | npx | — |
| firecrawl | npx | `FIRECRAWL_API_KEY` *(optional)* |
| exa-web-search | npx | `EXA_API_KEY` *(optional)* |

> **Note:** Keep max 10 MCPs active at once to preserve context window.

## Installation

**1. Clone everything-claude-code**
```powershell
git clone https://github.com/affaan-m/everything-claude-code C:\Users\YOUR_USERNAME\Desktop\repos\everything-claude-code
```

**2. Edit the script** — open `setup-claude-code.ps1` and update the paths at the top:
```powershell
$REPO   = "C:\Users\YOUR_USERNAME\Desktop\repos\everything-claude-code"
$CLAUDE = "C:\Users\YOUR_USERNAME\.claude"
$CLAUDE_JSON = "C:\Users\YOUR_USERNAME\.claude.json"
```

**3. Run the script**
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setup-claude-code.ps1
```

**4. Fill in your API keys** — open `~/.claude.json` and replace the placeholders:
```
GITHUB_PERSONAL_ACCESS_TOKEN  -> github.com/settings/tokens  (repo + read:org scope)
YOUR_SUPABASE_PROJECT_REF     -> supabase.com > project > Settings > General
```

## Context Modes

Load a context at the start of a Claude Code session:

```
/dev      - Development mode
/research - Research mode  
/review   - Code review mode
```

## CLAUDE.md

This script does **not** create a `CLAUDE.md` for you. You should create your own at `~/.claude/CLAUDE.md` with your stack, preferences and global rules. See the [examples](https://github.com/affaan-m/everything-claude-code/tree/main/examples) in the original repo for inspiration.

## Credits

All agents, commands, skills, rules, hooks and contexts are sourced from [everything-claude-code](https://github.com/affaan-m/everything-claude-code) by [@affaanmustafa](https://x.com/affaanmustafa). This repo is just an opinionated install script on top of it.

## License

MIT
