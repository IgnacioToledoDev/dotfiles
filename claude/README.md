# Claude Code Configuration

> **English** · [Español](#configuración-de-claude-code)

---

## English

Personal configuration for [Claude Code](https://claude.ai/code) — Anthropic's AI-powered CLI for software engineering.

### What's included

| File | Purpose |
|------|---------|
| `settings.json` | Plugins, hooks, status line, permissions, theme |
| `hooks/caveman-activate.js` | SessionStart hook — activates caveman terse mode |
| `hooks/caveman-config.js` | Shared config resolver for caveman mode |
| `hooks/caveman-mode-tracker.js` | UserPromptSubmit hook — tracks active mode per turn |
| `hooks/caveman-stats.js` | Token usage stats for caveman sessions |
| `hooks/caveman-statusline.sh` | Status line badge (Linux/macOS) |
| `hooks/caveman-statusline.ps1` | Status line badge (Windows) |
| `hooks/package.json` | CommonJS module marker for Node hooks |
| `install.sh` | One-shot setup script |

### Installed plugins

| Plugin | Source | Purpose |
|--------|--------|---------|
| [caveman](https://github.com/JuliusBrussee/caveman) | `caveman@caveman` | Ultra-terse communication mode — cuts ~65% of output tokens while keeping full technical accuracy |
| [superpowers](https://github.com/superpowers-sh/superpowers) | `superpowers@claude-plugins-official` | Skills system: brainstorming, TDD, debugging workflows, plan execution |
| [frontend-design](https://github.com/superpowers-sh/superpowers) | `frontend-design@claude-plugins-official` | Frontend and UI design skills |

### Requirements

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed
- [mise](https://mise.jdx.dev/) with Node.js ≥ 18 (hooks use `~/.local/share/mise/shims/node`)
  - Without mise: edit the node path in `settings.json` after install (see below)

### Installation

```bash
bash ~/workspace/dotfiles/claude/install.sh
```

The script:
1. Backs up `~/.claude/settings.json` if it exists
2. Symlinks `settings.json` and all hooks into `~/.claude/`
3. Installs all three plugins via `claude plugins install`

#### Without mise

After running install.sh, update the node path in `~/.claude/settings.json`:

```bash
sed -i "s|\$HOME/.local/share/mise/shims/node|$(which node)|g" ~/.claude/settings.json
```

### Caveman mode

Activated automatically on every session start. Controls verbosity:

| Command | Effect |
|---------|--------|
| `/caveman lite` | Drop filler, keep articles |
| `/caveman full` | Drop articles + filler (default) |
| `/caveman ultra` | Maximum compression |
| `stop caveman` / `normal mode` | Deactivate |

Status line shows `[CAVEMAN]` or `[CAVEMAN:ULTRA]` when active.

---

## Configuración de Claude Code

Configuración personal para [Claude Code](https://claude.ai/code) — el CLI de IA de Anthropic para desarrollo de software.

### Qué incluye

| Archivo | Propósito |
|---------|-----------|
| `settings.json` | Plugins, hooks, barra de estado, permisos, tema |
| `hooks/caveman-activate.js` | Hook SessionStart — activa el modo conciso caveman |
| `hooks/caveman-config.js` | Resolución de configuración compartida para caveman |
| `hooks/caveman-mode-tracker.js` | Hook UserPromptSubmit — rastrea el modo activo por turno |
| `hooks/caveman-stats.js` | Estadísticas de tokens para sesiones caveman |
| `hooks/caveman-statusline.sh` | Badge en la barra de estado (Linux/macOS) |
| `hooks/caveman-statusline.ps1` | Badge en la barra de estado (Windows) |
| `hooks/package.json` | Marcador CommonJS para hooks de Node |
| `install.sh` | Script de instalación |

### Plugins instalados

| Plugin | Fuente | Propósito |
|--------|--------|-----------|
| [caveman](https://github.com/JuliusBrussee/caveman) | `caveman@caveman` | Modo de comunicación ultra-conciso — reduce ~65% de tokens de salida sin perder precisión técnica |
| [superpowers](https://github.com/superpowers-sh/superpowers) | `superpowers@claude-plugins-official` | Sistema de skills: brainstorming, TDD, debugging, ejecución de planes |
| [frontend-design](https://github.com/superpowers-sh/superpowers) | `frontend-design@claude-plugins-official` | Skills de diseño frontend y UI |

### Requisitos

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) instalado
- [mise](https://mise.jdx.dev/) con Node.js ≥ 18 (los hooks usan `~/.local/share/mise/shims/node`)
  - Sin mise: actualizar la ruta de node en `settings.json` después de instalar (ver abajo)

### Instalación

```bash
bash ~/workspace/dotfiles/claude/install.sh
```

El script:
1. Hace backup de `~/.claude/settings.json` si existe
2. Crea symlinks de `settings.json` y todos los hooks en `~/.claude/`
3. Instala los tres plugins con `claude plugins install`

#### Sin mise

Después de ejecutar install.sh, actualiza la ruta de node en `~/.claude/settings.json`:

```bash
sed -i "s|\$HOME/.local/share/mise/shims/node|$(which node)|g" ~/.claude/settings.json
```

### Modo caveman

Se activa automáticamente al iniciar cada sesión. Controla el nivel de verbosidad:

| Comando | Efecto |
|---------|--------|
| `/caveman lite` | Elimina muletillas, mantiene artículos |
| `/caveman full` | Elimina artículos + muletillas (por defecto) |
| `/caveman ultra` | Compresión máxima |
| `stop caveman` / `normal mode` | Desactivar |

La barra de estado muestra `[CAVEMAN]` o `[CAVEMAN:ULTRA]` cuando está activo.
