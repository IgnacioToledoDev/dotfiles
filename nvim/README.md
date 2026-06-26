# Neovim Config — LazyVim

Personal config based on [LazyVim](https://lazyvim.github.io).

***Language***
- 🇺🇸 English
- [🇪🇸 Español](./README.es.md)

## Documentation

| File | Content |
|------|---------|
| [`Shortcuts.md`](./Shortcuts.md) | Essential Neovim and plugin shortcuts |
| [`DEV_TRICKS.md`](./DEV_TRICKS.md) | Advanced developer tricks |

---

## Installed Plugins

### Core
| Plugin | Usage |
|--------|-------|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Floating terminal (`Ctrl-\`) |
| [nvim-dbee](https://github.com/kndndrj/nvim-dbee) | Database client (`<leader>db`) |

### Active LazyVim Extras
| Extra | Description |
|-------|-------------|
| `lang.typescript` + `vtsls` | TypeScript with vtsls LSP |
| `lang.php` | PHP + Intelephense |
| `lang.tailwind` | Tailwind CSS |
| `lang.twig` | Twig templates |
| `lang.docker` | Dockerfile support |
| `lang.json` | JSON with schemas |
| `lang.yaml` | YAML with schemas |
| `lang.markdown` | Markdown preview and formatting |
| `ui.dashboard-nvim` | Startup dashboard |
| `ui.mini-animate` | Smooth animations |
| `ui.smear-cursor` | Smear cursor effect |
| `util.mini-hipatterns` | Pattern highlighting (hex colors, etc.) |
| `ai.claudecode` | Claude Code integration |

---

## Key Shortcuts (summary)

| Shortcut | Action |
|----------|--------|
| `<Space><Space>` | Find files |
| `<Space>fg` | Live grep in project |
| `<Space>e` | File explorer |
| `<Space>gg` | LazyGit |
| `<Space>ca` | Code actions |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `Ctrl-\` | Floating terminal |
| `<Space>fv` | Vertical split terminal |
| `<Space>db` | Open DBee |

---

## Structure

```
~/.config/nvim/
├── lua/
│   ├── config/
│   │   └── keymaps.lua     # Custom keymaps
│   └── plugins/
│       ├── toggleterm.lua  # Floating terminal
│       ├── dbee.lua        # DB client
│       └── dashboard.lua   # Dashboard
├── lazyvim.json            # Enabled LazyVim extras
├── Shortcuts.md            # Shortcut reference
└── DEV_TRICKS.md           # Developer tricks
```
