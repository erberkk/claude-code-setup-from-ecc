# ============================================================
# Claude Code Full Setup Script
# Based on: https://github.com/affaan-m/everything-claude-code
# ============================================================

$REPO        = "C:\Users\<USER>\Desktop\repos\everything-claude-code"
$CLAUDE      = "C:\Users\<USER>\.claude"
$CLAUDE_JSON = "C:\Users\<USER>\.claude.json"

function Green($msg)  { Write-Host $msg -ForegroundColor Green }
function Yellow($msg) { Write-Host $msg -ForegroundColor Yellow }
function Cyan($msg)   { Write-Host $msg -ForegroundColor Cyan }
function Red($msg)    { Write-Host $msg -ForegroundColor Red }
function Gray($msg)   { Write-Host $msg -ForegroundColor DarkGray }

Cyan "============================================================"
Cyan "  Claude Code Full Setup Script"
Cyan "  Based on: everything-claude-code"
Cyan "============================================================"

if (-not (Test-Path $REPO)) {
    Red "ERROR: Repo not found: $REPO"
    Red "Clone it first: git clone https://github.com/affaan-m/everything-claude-code"
    exit 1
}

# Create directories
foreach ($f in @("agents","commands","rules","skills","hooks","contexts")) {
    $path = "$CLAUDE\$f"
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Green "Created directory: $path"
    }
}

# ============================================================
# 1. RULES
# ============================================================
Yellow "`n[1/6] Copying rules (common only)..."
$rules = @(
    "agents.md","coding-style.md","development-workflow.md","git-workflow.md",
    "hooks.md","patterns.md","performance.md","security.md","testing.md"
)
foreach ($file in $rules) {
    $src = "$REPO\rules\common\$file"
    if (Test-Path $src) { Copy-Item $src "$CLAUDE\rules\$file" -Force; Green "  + rules\$file" }
    else { Gray "  - rules\common\$file not found (skip)" }
}

# ============================================================
# 2. AGENTS
# ============================================================
Yellow "`n[2/6] Copying agents..."
$agents = @(
    "planner.md","architect.md","code-reviewer.md","security-reviewer.md",
    "tdd-guide.md","build-error-resolver.md","refactor-cleaner.md","doc-updater.md",
    "database-reviewer.md","e2e-runner.md","chief-of-staff.md"
)
foreach ($file in $agents) {
    $src = "$REPO\agents\$file"
    if (Test-Path $src) { Copy-Item $src "$CLAUDE\agents\$file" -Force; Green "  + agents\$file" }
    else { Gray "  - agents\$file not found (skip)" }
}

# ============================================================
# 3. COMMANDS
# ============================================================
Yellow "`n[3/6] Copying commands..."
$commands = @(
    "plan.md","tdd.md","code-review.md","build-fix.md","refactor-clean.md",
    "learn.md","checkpoint.md","verify.md","e2e.md","eval.md",
    "orchestrate.md","quality-gate.md","update-docs.md","test-coverage.md",
    "multi-plan.md","multi-backend.md","multi-frontend.md","multi-execute.md","multi-workflow.md"
)
foreach ($file in $commands) {
    $src = "$REPO\commands\$file"
    if (Test-Path $src) { Copy-Item $src "$CLAUDE\commands\$file" -Force; Green "  + commands\$file" }
    else { Gray "  - commands\$file not found (skip)" }
}

# ============================================================
# 4. SKILLS
# ============================================================
Yellow "`n[4/6] Copying skills..."
$skills = @(
    "coding-standards","backend-patterns","frontend-patterns","api-design",
    "tdd-workflow","e2e-testing","database-migrations","deployment-patterns",
    "docker-patterns","security-review","security-scan","ai-first-engineering",
    "agentic-engineering","autonomous-loops","iterative-retrieval",
    "cost-aware-llm-pipeline","eval-harness","verification-loop",
    "continuous-learning","continuous-learning-v2","strategic-compact","search-first"
)
foreach ($skill in $skills) {
    $src = "$REPO\skills\$skill"
    if (Test-Path $src) {
        $dest = "$CLAUDE\skills\$skill"
        if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }
        Copy-Item "$src\*" $dest -Recurse -Force
        Green "  + skills\$skill\"
    } else { Gray "  - skills\$skill not found (skip)" }
}

# ============================================================
# 5. HOOKS
# ============================================================
Yellow "`n[5/6] Copying hooks..."
$hooksSrc = "$REPO\hooks\hooks.json"
if (Test-Path $hooksSrc) {
    Copy-Item $hooksSrc "$CLAUDE\hooks\hooks.json" -Force
    Green "  + hooks\hooks.json"
} else { Gray "  - hooks\hooks.json not found (skip)" }

# ============================================================
# 6. CONTEXTS
# ============================================================
Yellow "`n[6/6] Copying contexts..."
foreach ($file in @("dev.md","research.md","review.md")) {
    $src = "$REPO\contexts\$file"
    if (Test-Path $src) { Copy-Item $src "$CLAUDE\contexts\$file" -Force; Green "  + contexts\$file" }
    else { Gray "  - contexts\$file not found (skip)" }
}

# ============================================================
# MCP SERVERS
# ============================================================
Yellow "`n  Writing MCP servers to .claude.json..."

$mcpJson = @'
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp-server"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "C:\\Users\\YOUR_USERNAME\\Desktop\\repos"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_GITHUB_PAT_HERE"
      }
    },
    "vercel": {
      "type": "http",
      "url": "https://mcp.vercel.com"
    },
    "supabase": {
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server-supabase@latest", "--project-ref=YOUR_SUPABASE_PROJECT_REF_HERE"]
    },
    "magic": {
      "command": "npx",
      "args": ["-y", "@magicuidesign/mcp@latest"]
    },
    "exa-web-search": {
      "command": "npx",
      "args": ["-y", "exa-mcp-server"],
      "env": {
        "EXA_API_KEY": "YOUR_EXA_API_KEY_HERE"
      }
    }
  }
}
'@
Set-Content -Path $CLAUDE_JSON -Value $mcpJson -Encoding UTF8
Green "  + .claude.json written with 15 MCP servers"

# ============================================================
# SUMMARY
# ============================================================
Cyan "`n============================================================"
Green "  Setup complete!"
Cyan "============================================================"

Write-Host ""
Cyan "What was installed:"
Write-Host "  Rules    : 9 files (common)"
Write-Host "  Agents   : 11 files"
Write-Host "  Commands : 19 slash commands"
Write-Host "  Skills   : 22 directories (language-agnostic)"
Write-Host "  Hooks    : hooks.json"
Write-Host "  Contexts : dev, research, review"
Write-Host "  MCP      : 9 servers"

Write-Host ""
Cyan "Available slash commands:"
Write-Host "  /plan              - Implementation planning"
Write-Host "  /tdd               - Test-driven development"
Write-Host "  /code-review       - Code review"
Write-Host "  /e2e               - E2E test generation"
Write-Host "  /eval              - AI output evaluation"
Write-Host "  /orchestrate       - Multi-agent coordination"
Write-Host "  /quality-gate      - Quality control"
Write-Host "  /test-coverage     - Coverage report"
Write-Host "  /update-docs       - Documentation update"
Write-Host "  /multi-plan        - Parallel planning"
Write-Host "  /checkpoint        - Save state"
Write-Host "  /verify            - Verification loop"
Write-Host "  /learn             - Pattern extraction"
Write-Host "  /build-fix         - Fix build errors"
Write-Host "  /refactor-clean    - Dead code removal"

Write-Host ""
Red "!! ACTION REQUIRED: Fill in your values in .claude.json !!"
Write-Host "  $CLAUDE_JSON"
Write-Host ""
Write-Host "  filesystem path                -> update to your repos directory"
Write-Host "  GITHUB_PERSONAL_ACCESS_TOKEN   -> github.com/settings/tokens (repo + read:org)"
Write-Host "  YOUR_SUPABASE_PROJECT_REF      -> supabase.com > project > Settings > General"
Write-Host ""
Yellow "Optional:"
Write-Host "  FIRECRAWL_API_KEY  -> firecrawl.dev"
Write-Host "  EXA_API_KEY        -> exa.ai"
Write-Host "  insaits            -> pip install insa-its"
Write-Host ""
Yellow "WARNING: Keep max 10 MCPs active at once to preserve context window!"
Write-Host ""
Cyan "Context modes in Claude Code:"
Write-Host "  /dev      - Development mode"
Write-Host "  /research - Research mode"
Write-Host "  /review   - Code review mode"
Write-Host ""
