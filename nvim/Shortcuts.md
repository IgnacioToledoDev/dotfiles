# Neovim Shortcuts — LazyVim

> `<leader>` = **Space**. `C` = Ctrl, `S` = Shift.

***Language***
- 🇺🇸 English
- [🇪🇸 Español](./Shortcuts.es.md)

---

## Basic Movement

| Shortcut | Action |
|----------|--------|
| `h j k l` | Left / Down / Up / Right |
| `w` / `b` | Next / Previous word |
| `e` | End of word |
| `0` / `^` / `$` | Line start / First char / Line end |
| `gg` / `G` | File start / File end |
| `{` / `}` | Previous / Next block |
| `%` | Jump to matching `() [] {}` |
| `Ctrl-d` / `Ctrl-u` | Half page down / up |
| `zz` | Center cursor on screen |

---

## Editing

| Shortcut | Action |
|----------|--------|
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at line start / end |
| `o` / `O` | New line below / above |
| `ciw` | Change entire word |
| `ci"` | Change content inside quotes |
| `di(` | Delete content inside parentheses |
| `yiw` | Yank word |
| `dd` / `yy` | Delete / Yank line |
| `p` / `P` | Paste after / before |
| `u` / `Ctrl-r` | Undo / Redo |
| `.` | Repeat last action |
| `~` | Toggle case of char |
| `gc` + motion | Comment (visual: `gc`) |

---

## Visual Selection

| Shortcut | Action |
|----------|--------|
| `v` | Char-wise visual |
| `V` | Line-wise visual |
| `Ctrl-v` | Block visual |
| `viw` / `vip` | Select word / paragraph |
| `va"` | Select including quotes |

---

## Search

| Shortcut | Action |
|----------|--------|
| `/text` | Search forward |
| `?text` | Search backward |
| `n` / `N` | Next / Previous result |
| `*` / `#` | Search word under cursor (forward/back) |
| `<leader>sr` | Search and replace (Spectre) |

---

## Files and Fuzzy Finder (Snacks/Telescope)

| Shortcut | Action |
|----------|--------|
| `<leader><space>` | Find project files |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fb` | Open buffers |
| `<leader>fg` | Live grep (search text in project) |
| `<leader>/` | Grep in current buffer |
| `<leader>e` | File explorer (Neo-tree) |
| `<leader>E` | Neo-tree at project root |

---

## Buffers and Windows

| Shortcut | Action |
|----------|--------|
| `<leader>bd` | Close current buffer |
| `<leader>bo` | Close other buffers |
| `[b` / `]b` | Previous / Next buffer |
| `<leader>bb` | Last buffer |
| `<C-h/j/k/l>` | Navigate between windows |
| `<leader>w\|` | Vertical split |
| `<leader>w-` | Horizontal split |
| `<leader>wd` | Close window |
| `<leader>wm` | Maximize window (toggle) |

---

## LSP (Code)

| Shortcut | Action |
|----------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | View references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover — documentation |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format file |
| `<leader>cd` | Line diagnostic |
| `]d` / `[d` | Next / Previous diagnostic |
| `]e` / `[e` | Next / Previous error |
| `]w` / `[w` | Next / Previous warning |

---

## Git (LazyGit + Gitsigns)

| Shortcut | Action |
|----------|--------|
| `<leader>gg` | Open LazyGit |
| `<leader>gd` | Diff current file |
| `<leader>gb` | Blame line |
| `<leader>gs` | Stage hunk (Gitsigns) |
| `<leader>gS` | Stage entire buffer |
| `<leader>gr` | Reset hunk |
| `]h` / `[h` | Next / Previous hunk |
| `<leader>gl` | Commit log |

---

## Terminal

| Shortcut | Action |
|----------|--------|
| `Ctrl-\` | Open/close floating terminal (ToggleTerm) |
| `<leader>fv` | Terminal in right vertical split |
| `<Esc>` (in terminal) | Exit terminal mode |
| `<C-h/j/k/l>` (in terminal) | Navigate to adjacent window |

---

## DBee (Database)

| Shortcut | Action |
|----------|--------|
| `<leader>db` | Open/close DBee |

> Inside DBee: press `?` to see internal shortcuts.

---

## LazyVim Utilities

| Shortcut | Action |
|----------|--------|
| `<leader>l` | Open Lazy (plugin manager) |
| `<leader>cm` | Mason (LSP/tools manager) |
| `<leader>qq` | Quit Neovim |
| `<leader>un` | Dismiss notifications |
| `<leader>uC` | Change colorscheme |
| `<leader>ul` | Toggle line numbers |
| `<leader>uw` | Toggle word wrap |
| `<leader>ui` | Inspect pos (highlight groups) |

---

## Tabs

| Shortcut | Action |
|----------|--------|
| `<leader><tab>l` | Last tab |
| `<leader><tab>f` | First tab |
| `<leader><tab><tab>` | New tab |
| `<leader><tab>d` | Close tab |
| `]<tab>` / `[<tab>` | Next / Previous tab |
