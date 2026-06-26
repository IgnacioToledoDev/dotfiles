# Neovim — Developer Tricks

> Complement to `Shortcuts.md`. Focused on real-world productivity.

***Language***
- 🇺🇸 English
- [🇪🇸 Español](./DEV_TRICKS.es.md)

---

## Macros — Automate Repetition

| Shortcut | Action |
|----------|--------|
| `qa` | Record macro to register `a` |
| `q` | Stop recording |
| `@a` | Run macro `a` |
| `@@` | Repeat last macro |
| `10@a` | Run macro `a` 10 times |

> **Trick:** Select 50 lines in visual, then `:norm @a` — runs the macro on each line.

---

## Text Objects — Edit Precise Blocks

Format: `[operation][i/a][object]` — `i` = inner (no delimiter), `a` = around (with delimiter).

| Shortcut | Action |
|----------|--------|
| `ciw` | Change word |
| `ci"` / `ci'` / `` ci` `` | Change string content |
| `ci(` / `ci{` / `ci[` | Change inside parens/braces/brackets |
| `cit` | Change inside HTML/XML tag |
| `dap` | Delete entire paragraph |
| `yis` | Yank sentence |
| `vaf` | Select entire function |

---

## Registers — Multiple Clipboards

| Shortcut | Action |
|----------|--------|
| `"ayy` | Copy line to register `a` |
| `"ap` | Paste from register `a` |
| `"+y` | Copy to system clipboard |
| `"+p` | Paste from system clipboard |
| `"0p` | Paste last yank (ignores deletes) |
| `:reg` | View all registers |

> **Key trick:** `dd` overwrites the default register. Use `"0p` to paste what you yanked before deleting something.

---

## Marks — Jump Between Code Points

| Shortcut | Action |
|----------|--------|
| `ma` | Create mark `a` at current line |
| `` `a `` | Jump to mark `a` (line + column) |
| `'a` | Jump to the line of mark `a` |
| `` `. `` | Jump to last edited location |
| `` `[ `` / `` `] `` | Start / end of last yank or change |
| `` `< `` / `` `> `` | Start / end of last visual selection |
| `:marks` | View all marks |

---

## Advanced Search and Substitution

```vim
" Replace in file
:%s/old/new/g

" With confirmation
:%s/old/new/gc

" Only in visual selection (press : in visual mode)
:'<,'>s/old/new/g

" Case insensitive
:%s/old/new/gi

" Replace exact word (no substring)
:%s/\<old\>/new/g

" Replace across all open buffers
:bufdo %s/old/new/ge | update
```

> **Trick:** `cgn` — changes the next occurrence of the active search. Then `.` repeats to the next. Ultra fast for refactoring.

---

## Jump List and Change List

| Shortcut | Action |
|----------|--------|
| `Ctrl-o` | Jump back (jump list) |
| `Ctrl-i` | Jump forward (jump list) |
| `g;` | Go to previous change (change list) |
| `g,` | Go to next change (change list) |

> **Useful:** Go to a definition with `gd`, explore, come back with `Ctrl-o`.

---

## Quickfix — Navigate Errors and Searches

| Shortcut | Action |
|----------|--------|
| `<leader>xq` | Open Quickfix list |
| `<leader>xl` | Open Location list |
| `]q` / `[q` | Next / Previous quickfix item |
| `:cdo s/old/new/g` | Apply substitution to all quickfix items |

> **Pro trick:** Grep with `<leader>fg`, select results — they become your quickfix. Edit all with `:cdo`.

---

## Indentation and Formatting

| Shortcut | Action |
|----------|--------|
| `>>` / `<<` | Indent / Dedent line |
| `>` / `<` (visual) | Indent / Dedent selection |
| `=` (visual) | Auto-indent selection |
| `gg=G` | Auto-indent entire file |
| `<leader>cf` | Format with LSP/Prettier/etc |

---

## Numbers and Increment

| Shortcut | Action |
|----------|--------|
| `Ctrl-a` | Increment number under cursor |
| `Ctrl-x` | Decrement number under cursor |
| `10Ctrl-a` | Increment by 10 |
| `g Ctrl-a` | (visual) Sequential increment: 1, 2, 3... |

> **Trick:** Select multiple lines with the same number in visual, `g Ctrl-a` enumerates them in sequence.

---

## Splits and Efficient Layout

| Shortcut | Action |
|----------|--------|
| `<C-w>=` | Equalize all split sizes |
| `<C-w>_` | Maximize split horizontally |
| `<C-w>\|` | Maximize split vertically |
| `<C-w>r` | Rotate windows |
| `<C-w>T` | Move split to new tab |
| `<C-w>x` | Swap with adjacent window |

---

## Folding

| Shortcut | Action |
|----------|--------|
| `za` | Toggle fold under cursor |
| `zc` / `zo` | Close / Open fold |
| `zM` | Close all folds |
| `zR` | Open all folds |
| `zj` / `zk` | Next / Previous fold |

---

## Useful Command-Line Commands

```vim
" Sort selected lines
:'<,'>sort

" Delete duplicate lines
:sort u

" Delete blank lines
:g/^$/d

" Delete lines matching pattern
:g/console.log/d

" Run shell command and insert output
:r !date

" Diff against saved version on disk
:w !diff % -
```

---

## Code Navigation (LSP)

| Shortcut | Action |
|----------|--------|
| `gd` → `Ctrl-o` | Go to definition and return |
| `<leader>ss` | Search symbol in file |
| `<leader>sS` | Search symbol in workspace |
| `<leader>xd` | All project diagnostics |
| `<leader>xe` | Errors only |

---

## Snacks — Hidden Features

| Shortcut | Action |
|----------|--------|
| `<leader>n` | Recent notifications |
| `<leader>bd` | Delete buffer without closing split |
| `<leader>bo` | Close all buffers except current |
| `z.` | Smooth scroll to cursor (mini-animate) |

---

## Visual Selection Tricks

```
# Select to end of line (no newline)
v$h

# Select entire function block
vaf   (requires treesitter)

# Expand selection with treesitter
<leader> while in visual mode
```

| Shortcut | Action |
|----------|--------|
| `gv` | Reselect last visual selection |
| `o` (in visual) | Move cursor to other end of selection |

---

## TypeScript / PHP — Specific

| Shortcut | Action |
|----------|--------|
| `<leader>co` | Organize imports (TS) |
| `<leader>cR` | Restart LSP |
| `<leader>ci` | Active LSP info |
| `]e` / `[e` | Navigate type errors |

> **Trick:** `:LspInfo` to see which servers are active in the current file.

---

## Clipboard — System

Add to config if `"+y` doesn't work:

```lua
vim.opt.clipboard = "unnamedplus"  -- Sync with system clipboard
```

With this, `y` and `p` use the system clipboard directly.

---

## Productivity Misc

| Shortcut / Command | Action |
|--------------------|--------|
| `J` | Join next line to current |
| `gJ` | Join without adding space |
| `xp` | Swap char with next |
| `ddp` | Move line one position down |
| `ddkP` | Move line one position up |
| `:earlier 5m` | Undo to state 5 minutes ago |
| `:later 30s` | Redo to state 30 seconds ago |
| `q:` | Command history |
| `q/` | Search history |
