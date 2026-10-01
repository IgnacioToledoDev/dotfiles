# Claude Code Configuration / Configuración de Claude Code

Personal configuration for [Claude Code](https://claude.ai/code) — Anthropic's AI-powered CLI for software engineering.  
Configuración personal para [Claude Code](https://claude.ai/code) — el CLI de IA de Anthropic para desarrollo de software.

---

## What's included / Qué incluye

| File / Archivo | Purpose / Propósito |
|----------------|---------------------|
| `settings.json` | Plugins, hooks, status line, permissions, model, theme / Plugins, hooks, barra de estado, permisos, modelo, tema |
| `CLAUDE.md` | Global instructions loaded every session, incl. the gentle-ai ODD/SDD orchestrator block / Instrucciones globales cargadas cada sesión, incl. el bloque orquestador ODD/SDD de gentle-ai |
| `hooks/caveman-activate.js` | SessionStart hook — activates caveman terse mode / activa el modo conciso caveman |
| `hooks/caveman-config.js` | Shared config resolver for caveman / Resolución de configuración compartida |
| `hooks/caveman-mode-tracker.js` | UserPromptSubmit hook — tracks active mode per turn / rastrea el modo activo por turno |
| `hooks/caveman-stats.js` | Token usage stats / Estadísticas de tokens |
| `hooks/caveman-statusline.sh` | Status line badge (Linux/macOS) / Badge en barra de estado |
| `hooks/caveman-statusline.ps1` | Status line badge (Windows) / Badge en barra de estado (Windows) |
| `hooks/package.json` | CommonJS module marker for Node hooks |
| `install.sh` | One-shot setup script / Script de instalación |

---

## Plugins

| Plugin | Source / Fuente | Purpose / Propósito |
|--------|-----------------|---------------------|
| [caveman](https://github.com/JuliusBrussee/caveman) | `caveman@caveman` | Ultra-terse mode, ~65% fewer output tokens / Modo ultra-conciso, ~65% menos tokens de salida |
| [superpowers](https://github.com/superpowers-sh/superpowers) | `superpowers@claude-plugins-official` | Skills: brainstorming, TDD, debugging, plan execution / Skills: brainstorming, TDD, debugging, ejecución de planes |
| [frontend-design](https://github.com/superpowers-sh/superpowers) | `frontend-design@claude-plugins-official` | Frontend and UI design skills / Skills de diseño frontend y UI |
| [engram](https://github.com/Gentleman-Programming/engram) | `engram@engram` | Persistent cross-session memory (decisions, bugs, conventions) / Memoria persistente entre sesiones (decisiones, bugs, convenciones) |
| atlassian | `atlassian@claude-plugins-official` | Jira/Confluence integration / Integración con Jira/Confluence |
| code-review | `code-review@claude-plugins-official` | `/code-review` PR review skill / Skill de revisión de PRs |
| context7 | `context7@claude-plugins-official` | Up-to-date library/framework docs lookup / Consulta de docs actualizados de librerías |
| figma | `figma@claude-plugins-official` | Figma design ↔ code workflows / Flujos Figma ↔ código |
| lua-lsp, php-lsp, rust-analyzer-lsp | `*-lsp@claude-plugins-official` | Language server integrations / Integraciones de language server |
| redis-development | `redis-development@claude-plugins-official` | Redis modeling, clustering, search skills / Skills de modelado, clustering, búsqueda en Redis |
| sentry | `sentry@claude-plugins-official` | Error tracking workflows / Flujos de seguimiento de errores |
| shopify-ai-toolkit | `shopify-ai-toolkit@claude-plugins-official` | Shopify app development skills / Skills de desarrollo de apps Shopify |
| skill-creator | `skill-creator@claude-plugins-official` | Create/audit/improve skills / Crear, auditar y mejorar skills |
| sonarqube | `sonarqube@claude-plugins-official` | Quality gate, issues, coverage, dependency risk / Quality gate, issues, cobertura, riesgo de dependencias |
| stripe | `stripe@claude-plugins-official` | Stripe API/error/test-card skills / Skills de API, errores y tarjetas de prueba de Stripe |

Extra marketplaces registered in `settings.json` (`extraKnownMarketplaces`) so these plugins resolve without manual `marketplace add`: `caveman` (JuliusBrussee/caveman), `clean-architecture-skills` (nathankim0/clean-architecture-skills, installed per-project, not global), `engram` (Gentleman-Programming/engram).

---

## gentle-ai (Gentleman-Programming) integration

[gentle-ai](https://github.com/Gentleman-Programming) is a CLI that turns Claude Code into an orchestrator running **Organic Driven Development (ODD)** by default, with an optional **Spec-Driven Development (SDD)** branch and a receipt-driven review (RDD) system. It plugs in two ways:

1. **`CLAUDE.md`** — ships the "Agent Teams Lite" orchestrator block: ODD protocol (authorize → explore → resolve uncertainty → classify → track → implement task-by-task → close), delegation rules (when to spawn sub-agents vs. work inline), model assignments per SDD phase, and the native review (RDD) lifecycle contract. SDD itself (`sdd-propose`, `sdd-spec`, `sdd-design`, `sdd-tasks`, `sdd-apply`, `sdd-verify`, `sdd-archive`) is lazy-loaded from `.claude/skills/_shared/sdd-orchestrator-workflow.md` only when explicitly selected — it's not the default flow.
2. **`settings.json` hooks** — wire gentle-ai's CLI into the session lifecycle:
   - `PreToolUse` (matcher `Agent`): `gentle-ai sdd-preflight-hook` — checks SDD state before a sub-agent spawns.
   - `SessionStart` (matcher `startup|resume|clear|compact`): `gentle-ai review stop-hook` — reconciles any pending review state.
   - `Stop`: `gentle-ai review stop-hook` + async `gentle-ai telemetry runtime claude --json`.
   - `SubagentStop`: async `gentle-ai telemetry runtime claude --json`.
   - `UserPromptSubmit`: `gentle-ai skill-registry refresh --quiet --no-gitignore` — keeps the project's skill index current.

RDD (receipt-driven development) is the review layer: it's **on by default, opt-out** via `gentle-ai review mode enable|disable|status`. When enabled, a work-unit commit gets risk-assessed (`gentle-ai review assess`) and — for medium/high risk — goes through a 4-lens native review (risk, resilience, readability, reliability) before being acknowledged. Delivery (commit/push/PR) always stays under ordinary repo policy; review is informational, never a merge gate by itself.

Requires the `gentle-ai` CLI in `$PATH` — `install.sh` warns if it's missing (hooks will no-op/fail otherwise).

---

## CodeGraph

Also wired through `CLAUDE.md` + the `codegraph` MCP server/plugin: a per-project SQLite index (`.codegraph/`) of symbols, call paths, and blast radius. `CLAUDE.md` makes `codegraph_explore` (or the read-only `codegraph` CLI) the **required first step** for structural/codebase questions, before broad `Read`/`Glob`/`Grep`. A missing `.codegraph/` triggers lazy `gentle-ai codegraph init`, never a reason to skip it. Destructive/admin subcommands (`uninit`, `install`, `uninstall`, `upgrade`) are explicitly off-limits for the agent.

A `UserPromptSubmit` hook runs `codegraph prompt-hook` every turn to keep it in sync with the conversation.

---

## Engram memory

The `engram` plugin gives Claude persistent memory across sessions (decisions, bugfixes, conventions, project context) stored outside the conversation. `CLAUDE.md` makes saving **proactive and mandatory**: `mem_save` after any decision/bugfix/discovery, `mem_context` → `mem_search` → `mem_get_observation` when referencing past work, `mem_session_summary` before declaring a task done. Memory writes are bookkeeping — they never replace or get folded into the user-facing answer.

---

## Permissions & safety

`settings.json` sets `defaultMode: bypassPermissions` with `skipDangerousModePermissionPrompt: true` (no per-tool-call prompts) plus an explicit `deny` list covering the stuff that should never be read/edited regardless of mode: `.env*`, `.ssh/*`, `.credentials/*`, keychains, `.aws/credentials`, `gh` host config, `*.pem`, `*.key`, `**/secrets/*`. `rm -rf /` and `rm -rf ~` (with and without `sudo`) are denied outright. `allow` explicitly opens `mcp__pencil` and `mcp__codegraph__*`.

`model: sonnet`, `effortLevel: high`, `outputStyle: Neutral`, `theme: dark`, `tui: fullscreen`, and `env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` (enables the Agent Teams / sub-agent orchestration feature the gentle-ai block above depends on).

---

## Requirements / Requisitos

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed / instalado
- [mise](https://mise.jdx.dev/) with / con Node.js ≥ 18
- `gentle-ai` CLI in `$PATH` (powers the SDD/ODD/RDD hooks) / CLI `gentle-ai` en el `$PATH` (impulsa los hooks SDD/ODD/RDD)
- `codegraph` CLI in `$PATH` (optional — only needed for the `UserPromptSubmit` prompt-hook and CLI fallback when the MCP tool is unavailable) / CLI `codegraph` en el `$PATH` (opcional)

Hooks use `~/.local/share/mise/shims/node`. Without mise, update the node path after install (see below).  
Los hooks usan `~/.local/share/mise/shims/node`. Sin mise, actualiza la ruta de node tras instalar (ver abajo).

---

## Installation / Instalación

```bash
bash ~/dotfiles/claude/install.sh
```

The script / El script:
1. Backs up `~/.claude/settings.json` and `~/.claude/CLAUDE.md` if they exist and aren't symlinks / Hace backup de `~/.claude/settings.json` y `~/.claude/CLAUDE.md` si existen
2. Symlinks `settings.json`, `CLAUDE.md`, and hooks into `~/.claude/` / Crea symlinks en `~/.claude/`
3. Installs every plugin listed above via `claude plugins install` / Instala todos los plugins listados arriba
4. Warns if `gentle-ai` or `codegraph` are missing from `$PATH` / Avisa si faltan `gentle-ai` o `codegraph` en el `$PATH`

### Without mise / Sin mise

```bash
sed -i "s|\$HOME/.local/share/mise/shims/node|$(which node)|g" ~/.claude/settings.json
```

---

## Caveman mode / Modo caveman

Activated automatically on every session start. Controls verbosity.  
Se activa automáticamente al iniciar cada sesión. Controla el nivel de verbosidad.

| Command / Comando | Effect / Efecto |
|-------------------|-----------------|
| `/caveman lite` | Drop filler, keep articles / Elimina muletillas, mantiene artículos |
| `/caveman full` | Drop articles + filler — default / Elimina artículos + muletillas — por defecto |
| `/caveman ultra` | Maximum compression / Compresión máxima |
| `stop caveman` / `normal mode` | Deactivate / Desactivar |

Status line shows `[CAVEMAN]` or `[CAVEMAN:ULTRA]` when active.  
La barra de estado muestra `[CAVEMAN]` o `[CAVEMAN:ULTRA]` cuando está activo.
