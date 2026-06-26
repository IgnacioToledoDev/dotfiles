# TMUX — Custom Configuration

> Repo: [IgnacioToledoDev/dotfiles](https://github.com/IgnacioToledoDev/dotfiles) — config at `tmux/.tmux.conf`

> Default tmux prefix (`Ctrl+b`) replaced by **`Ctrl+a`**.
> In this guide, `prefix` = `Ctrl+a`.

***Language***
- 🇺🇸 English
- [🇪🇸 Español](./TMUX.es.md)

---

## Prefix

| Shortcut | Action |
|----------|--------|
| `Ctrl+a` | Activate prefix (replaces `Ctrl+b`) |

---

## Windows

> Numbering starts at **1** (`base-index 1`). When a window is closed, they renumber automatically (`renumber-windows on`).

### Management

| Shortcut | Action |
|----------|--------|
| `prefix` + `c` | Create new window |
| `prefix` + `,` | Rename current window |
| `prefix` + `&` | Close current window (asks for confirmation) |

### Navigate Between Windows

| Shortcut | Action |
|----------|--------|
| `prefix` + `n` | **Next** window |
| `prefix` + `p` | **Previous** window |
| `prefix` + `[1-9]` | Go to window by number |
| `prefix` + `w` | Interactive window list |

---

## Sessions

### Manage From Terminal

```bash
tmux new -s <name>           # new named session
tmux ls                      # list active sessions
tmux attach -t <name>        # reconnect to existing session
tmux kill-session -t <name>  # destroy session
```

### Recover Session From Inside Tmux

| Shortcut | Action |
|----------|--------|
| `prefix` + `d` | Detach — session keeps running |
| `prefix` + `s` | Interactive session list (switch or reconnect) |
| `prefix` + `$` | Rename current session |

> Sessions persist as long as the tmux process is alive. To reconnect: `tmux attach` (last session) or `tmux attach -t <name>`.

---

## Panes

> Numbering starts at **1** (`pane-base-index 1`).

### Split Screen

| Shortcut | Action |
|----------|--------|
| `prefix` + `v` | Split **horizontally** (left / right) — inherits current directory |
| `prefix` + `d` | Split **vertically** (top / bottom) — inherits current directory |

### Navigate Between Panes

Vim-style — no arrow keys.

| Shortcut | Direction |
|----------|-----------|
| `prefix` + `h` | **Left** pane |
| `prefix` + `j` | **Down** pane |
| `prefix` + `k` | **Up** pane |
| `prefix` + `l` | **Right** pane |

### Resize Panes

Repeatable (without releasing prefix, thanks to `-r`).

| Shortcut | Action |
|----------|--------|
| `prefix` + `H` | Expand **left** |
| `prefix` + `J` | Expand **down** |
| `prefix` + `K` | Expand **up** |
| `prefix` + `L` | Expand **right** |

### Maximize Pane

| Shortcut | Action |
|----------|--------|
| `prefix` + `m` | **Zoom** current pane (toggle — press again to restore) |

---

## Mouse

Mouse enabled. You can:
- Click a pane to select it
- Drag pane borders to resize
- Scroll with the wheel to browse history

---

## Copy Mode (scroll / history)

Vim-style navigation enabled in copy mode.

| Step | Shortcut |
|------|----------|
| Enter copy mode | `prefix` + `[` |
| Move | `h j k l` / arrows |
| Start selection | `v` |
| Copy selection | `y` (copies to clipboard and exits mode) |
| Exit without copying | `q` |

---

## Status Bar

| Zone | Content |
|------|---------|
| Left | `[session-name]` in green |
| Right | Time (`HH:MM`) in yellow + date (`DD-Mon-YY`) in white |

---

## Plugins

Manager: **TPM** (Tmux Plugin Manager).

| Plugin | Description |
|--------|-------------|
| [tmux-kanagawa](https://github.com/Nybkox/tmux-kanagawa) | Visual theme + status bar with widgets |

### Active Bar Widgets (kanagawa)

| Widget | Shows |
|--------|-------|
| `git` | Current branch of directory |
| `cpu-usage` | CPU usage % |
| `ram-usage` | RAM usage % |

Theme configured: `dragon`.

---

## Installation After Cloning

### 1. Clone the repository

```bash
git clone https://github.com/IgnacioToledoDev/dotfiles ~/.dotfiles
```

### 2. Link the config

```bash
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

### 3. Install TPM

TPM is included as a submodule at `tmux/plugins/tpm`. If the directory is empty after cloning:

```bash
git -C ~/.dotfiles submodule update --init --recursive
```

Or install TPM manually:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 4. Install plugins

Open tmux and run:

```
prefix + I
```

> `prefix` = `Ctrl+a`. TPM downloads and installs all plugins defined in `.tmux.conf`.

---

## Quick Reference

```
Ctrl+a  →  prefix

Sessions:
  tmux new -s <name>      new session
  tmux attach -t <name>   reconnect
  tmux ls                 list
  prefix+d   detach (session stays alive)
  prefix+s   interactive session list
  prefix+$   rename session

Windows  (start at 1, renumber on close):
  c   new window
  ,   rename
  n/p navigate next/previous
  1-9 go to number

Panes  (start at 1):
  v   split horizontal (inherits path)
  d   split vertical (inherits path)
  h/j/k/l   navigate (vim)
  H/J/K/L   resize
  m   zoom toggle

Copy:
  prefix+[  enter copy mode
  v   select
  y   copy
```
