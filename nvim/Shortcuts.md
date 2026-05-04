# Neovim Shortcuts — LazyVim

> `<leader>` = **Espacio**. `C` = Ctrl, `S` = Shift.

---

## Movimiento Básico

| Atajo | Acción |
|-------|--------|
| `h j k l` | Izquierda / Abajo / Arriba / Derecha |
| `w` / `b` | Siguiente / Anterior palabra |
| `e` | Final de palabra |
| `0` / `^` / `$` | Inicio línea / Primer char / Fin línea |
| `gg` / `G` | Inicio / Fin del archivo |
| `{` / `}` | Bloque anterior / siguiente |
| `%` | Saltar al par de `() [] {}` |
| `Ctrl-d` / `Ctrl-u` | Media página abajo / arriba |
| `zz` | Centrar cursor en pantalla |

---

## Edición

| Atajo | Acción |
|-------|--------|
| `i` / `a` | Insert antes / después del cursor |
| `I` / `A` | Insert inicio / fin de línea |
| `o` / `O` | Nueva línea abajo / arriba |
| `ciw` | Cambiar palabra entera |
| `ci"` | Cambiar contenido entre comillas |
| `di(` | Borrar contenido entre paréntesis |
| `yiw` | Copiar palabra |
| `dd` / `yy` | Borrar / Copiar línea |
| `p` / `P` | Pegar después / antes |
| `u` / `Ctrl-r` | Deshacer / Rehacer |
| `.` | Repetir última acción |
| `~` | Cambiar mayús/minús del char |
| `gc` + movimiento | Comentar (visual: `gc`) |

---

## Selección Visual

| Atajo | Acción |
|-------|--------|
| `v` | Visual por char |
| `V` | Visual por línea |
| `Ctrl-v` | Visual en bloque |
| `viw` / `vip` | Seleccionar palabra / párrafo |
| `va"` | Seleccionar incluyendo comillas |

---

## Búsqueda

| Atajo | Acción |
|-------|--------|
| `/texto` | Buscar hacia adelante |
| `?texto` | Buscar hacia atrás |
| `n` / `N` | Siguiente / anterior resultado |
| `*` / `#` | Buscar palabra bajo cursor (adelante/atrás) |
| `<leader>sr` | Buscar y reemplazar (Spectre) |

---

## Archivos y Fuzzy Finder (Snacks/Telescope)

| Atajo | Acción |
|-------|--------|
| `<leader><space>` | Buscar archivos del proyecto |
| `<leader>ff` | Buscar archivos |
| `<leader>fr` | Archivos recientes |
| `<leader>fb` | Buffers abiertos |
| `<leader>fg` | Live grep (buscar texto en proyecto) |
| `<leader>/` | Grep en buffer actual |
| `<leader>e` | Explorador de archivos (Neo-tree) |
| `<leader>E` | Neo-tree raíz del proyecto |

---

## Buffers y Ventanas

| Atajo | Acción |
|-------|--------|
| `<leader>bd` | Cerrar buffer actual |
| `<leader>bo` | Cerrar otros buffers |
| `[b` / `]b` | Buffer anterior / siguiente |
| `<leader>bb` | Último buffer |
| `<C-h/j/k/l>` | Navegar entre ventanas |
| `<leader>w\|` | Split vertical |
| `<leader>w-` | Split horizontal |
| `<leader>wd` | Cerrar ventana |
| `<leader>wm` | Maximizar ventana (toggle) |

---

## LSP (Código)

| Atajo | Acción |
|-------|--------|
| `gd` | Ir a definición |
| `gD` | Ir a declaración |
| `gr` | Ver referencias |
| `gI` | Ir a implementación |
| `gy` | Ir a definición de tipo |
| `K` | Hover — documentación |
| `<leader>ca` | Code actions |
| `<leader>cr` | Renombrar símbolo |
| `<leader>cf` | Formatear archivo |
| `<leader>cd` | Diagnóstico de la línea |
| `]d` / `[d` | Siguiente / anterior diagnóstico |
| `]e` / `[e` | Siguiente / anterior error |
| `]w` / `[w` | Siguiente / anterior warning |

---

## Git (LazyGit + Gitsigns)

| Atajo | Acción |
|-------|--------|
| `<leader>gg` | Abrir LazyGit |
| `<leader>gd` | Diff del archivo actual |
| `<leader>gb` | Blame de la línea |
| `<leader>gs` | Staging de hunks (Gitsigns) |
| `<leader>gS` | Stage buffer completo |
| `<leader>gr` | Reset hunk |
| `]h` / `[h` | Siguiente / anterior hunk |
| `<leader>gl` | Log de commits |

---

## Terminal

| Atajo | Acción |
|-------|--------|
| `Ctrl-\` | Abrir/cerrar terminal flotante (ToggleTerm) |
| `<leader>fv` | Terminal en split vertical derecha |
| `<Esc>` (en terminal) | Salir del modo terminal |
| `<C-h/j/k/l>` (en terminal) | Navegar a ventana adyacente |

---

## DBee (Base de Datos)

| Atajo | Acción |
|-------|--------|
| `<leader>db` | Abrir/cerrar DBee |

> Dentro de DBee: usa `?` para ver los atajos internos.

---

## Utilidades LazyVim

| Atajo | Acción |
|-------|--------|
| `<leader>l` | Abrir Lazy (gestor de plugins) |
| `<leader>cm` | Mason (gestor de LSP/tools) |
| `<leader>qq` | Salir de Neovim |
| `<leader>un` | Descartar notificaciones |
| `<leader>uC` | Cambiar colorschema |
| `<leader>ul` | Toggle line numbers |
| `<leader>uw` | Toggle word wrap |
| `<leader>ui` | Inspect pos (highlight groups) |

---

## Tabs

| Atajo | Acción |
|-------|--------|
| `<leader><tab>l` | Último tab |
| `<leader><tab>f` | Primer tab |
| `<leader><tab><tab>` | Nuevo tab |
| `<leader><tab>d` | Cerrar tab |
| `]<tab>` / `[<tab>` | Siguiente / anterior tab |
