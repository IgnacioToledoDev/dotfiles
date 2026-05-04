# Neovim Config — LazyVim

Config personal basada en [LazyVim](https://lazyvim.github.io).

## Documentación

| Archivo | Contenido |
|---------|-----------|
| [`SHORTCUTS.md`](./SHORTCUTS.md) | Atajos esenciales de Neovim y plugins |
| [`DEV_TRICKS.md`](./DEV_TRICKS.md) | Trucos avanzados para desarrollo |

---

## Plugins Instalados

### Core
| Plugin | Uso |
|--------|-----|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal flotante (`Ctrl-\`) |
| [nvim-dbee](https://github.com/kndndrj/nvim-dbee) | Cliente de base de datos (`<leader>db`) |

### Extras LazyVim activos
| Extra | Descripción |
|-------|-------------|
| `lang.typescript` + `vtsls` | TypeScript con vtsls LSP |
| `lang.php` | PHP + Intelephense |
| `lang.tailwind` | Tailwind CSS |
| `lang.twig` | Templates Twig |
| `lang.docker` | Dockerfile support |
| `lang.json` | JSON con esquemas |
| `lang.yaml` | YAML con esquemas |
| `lang.markdown` | Markdown preview y formato |
| `ui.dashboard-nvim` | Dashboard de inicio |
| `ui.mini-animate` | Animaciones suaves |
| `ui.smear-cursor` | Cursor con efecto smear |
| `util.mini-hipatterns` | Highlight de patrones (colores hex, etc.) |
| `ai.claudecode` | Integración Claude Code |

---

## Atajos Clave (resumen)

| Atajo | Acción |
|-------|--------|
| `<Space><Space>` | Buscar archivos |
| `<Space>fg` | Live grep en el proyecto |
| `<Space>e` | Explorador de archivos |
| `<Space>gg` | LazyGit |
| `<Space>ca` | Code actions |
| `gd` | Ir a definición |
| `K` | Documentación hover |
| `Ctrl-\` | Terminal flotante |
| `<Space>fv` | Terminal split vertical |
| `<Space>db` | Abrir DBee |

---

## Estructura

```
~/.config/nvim/
├── lua/
│   ├── config/
│   │   └── keymaps.lua     # Atajos personalizados
│   └── plugins/
│       ├── toggleterm.lua  # Terminal flotante
│       ├── dbee.lua        # Cliente DB
│       └── dashboard.lua   # Dashboard
├── lazyvim.json            # Extras LazyVim habilitados
├── SHORTCUTS.md            # Referencia de atajos
└── DEV_TRICKS.md           # Trucos para desarrollo
```
