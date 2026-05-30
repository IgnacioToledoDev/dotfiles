# Claude Code Configuration / Configuración de Claude Code

Personal configuration for [Claude Code](https://claude.ai/code) — Anthropic's AI-powered CLI for software engineering.  
Configuración personal para [Claude Code](https://claude.ai/code) — el CLI de IA de Anthropic para desarrollo de software.

---

## What's included / Qué incluye

| File / Archivo | Purpose / Propósito |
|----------------|---------------------|
| `settings.json` | Plugins, hooks, status line, permissions, theme / Plugins, hooks, barra de estado, permisos, tema |
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

---

## Requirements / Requisitos

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed / instalado
- [mise](https://mise.jdx.dev/) with / con Node.js ≥ 18

Hooks use `~/.local/share/mise/shims/node`. Without mise, update the node path after install (see below).  
Los hooks usan `~/.local/share/mise/shims/node`. Sin mise, actualiza la ruta de node tras instalar (ver abajo).

---

## Installation / Instalación

```bash
bash ~/dotfiles/claude/install.sh
```

The script / El script:
1. Backs up `~/.claude/settings.json` if it exists / Hace backup de `~/.claude/settings.json` si existe
2. Symlinks `settings.json` and hooks into `~/.claude/` / Crea symlinks en `~/.claude/`
3. Installs all three plugins via `claude plugins install` / Instala los tres plugins

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
