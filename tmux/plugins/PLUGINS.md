# TMUX Plugins

Manager: **TPM** (Tmux Plugin Manager) — installed at `tmux/plugins/tpm`.

***Language***
- 🇺🇸 English
- [🇪🇸 Español](./PLUGINS.es.md)

## Included Plugins

| Plugin | Repo | Description |
|--------|------|-------------|
| tmux-kanagawa | [Nybkox/tmux-kanagawa](https://github.com/Nybkox/tmux-kanagawa) | Visual theme + status bar |

### Active Widgets (tmux-kanagawa)

| Widget | Shows |
|--------|-------|
| `git` | Current branch of the directory |
| `cpu-usage` | CPU usage % |
| `ram-usage` | RAM usage % |

Theme: `dragon`.

---

## Fresh Install

### 1. Install TPM

TPM ships as a submodule. Initialize it:

```bash
git submodule update --init --recursive
```

Or clone it manually to where tmux expects it:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 2. Install plugins

Plugins are **not in the repo** — TPM downloads them from GitHub on install.

Open tmux and run:

```
prefix + I
```

> `prefix` = `Ctrl+a`. TPM clones and installs all plugins defined in `.tmux.conf`, including `tmux-kanagawa`.

### 3. Reload config (if needed)

```bash
tmux source ~/.tmux.conf
```

---

## Add a New Plugin

1. Add in `.tmux.conf`:

```bash
set -g @plugin 'user/plugin-name'
```

2. Install with `prefix + I`.

## Update Plugins

```
prefix + U
```

## Remove a Plugin

1. Delete the `set -g @plugin` line in `.tmux.conf`.
2. Run `prefix + alt + u`.
