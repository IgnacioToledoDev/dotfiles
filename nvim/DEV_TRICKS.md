# Neovim — Trucos para Desarrolladores

> Complemento de `SHORTCUTS.md`. Enfoque en productividad real.

---

## Macros — Automatizar repetición

| Atajo | Acción |
|-------|--------|
| `qa` | Grabar macro en registro `a` |
| `q` | Detener grabación |
| `@a` | Ejecutar macro `a` |
| `@@` | Repetir último macro |
| `10@a` | Ejecutar macro `a` 10 veces |

> **Truco:** Selecciona 50 líneas en visual, luego `:norm @a` — ejecuta el macro en cada línea.

---

## Text Objects — Editar bloques precisos

Formato: `[operación][i/a][objeto]` — `i` = inner (sin delimitador), `a` = around (con delimitador).

| Atajo | Acción |
|-------|--------|
| `ciw` | Cambiar palabra |
| `ci"` / `ci'` / `` ci` `` | Cambiar contenido de string |
| `ci(` / `ci{` / `ci[` | Cambiar dentro de paréntesis/llaves/brackets |
| `cit` | Cambiar dentro de tag HTML/XML |
| `dap` | Borrar párrafo completo |
| `yis` | Copiar oración |
| `vaf` | Seleccionar función completa |

---

## Registers — Portapapeles múltiple

| Atajo | Acción |
|-------|--------|
| `"ayy` | Copiar línea al registro `a` |
| `"ap` | Pegar desde registro `a` |
| `"+y` | Copiar al portapapeles del sistema |
| `"+p` | Pegar desde portapapeles del sistema |
| `"0p` | Pegar último yank (ignora deletes) |
| `:reg` | Ver todos los registros |

> **Truco clave:** `dd` sobreescribe el registro default. Usa `"0p` para pegar lo que copiaste antes de borrar algo.

---

## Marks — Saltar entre puntos del código

| Atajo | Acción |
|-------|--------|
| `ma` | Crear mark `a` en línea actual |
| `` `a `` | Saltar al mark `a` (línea + columna) |
| `'a` | Saltar a la línea del mark `a` |
| `` `. `` | Saltar al último lugar editado |
| `` `[ `` / `` `] `` | Inicio / fin del último yank o cambio |
| `` `< `` / `` `> `` | Inicio / fin de última selección visual |
| `:marks` | Ver todos los marks |

---

## Búsqueda y Sustitución Avanzada

```vim
" Reemplazar en archivo
:%s/viejo/nuevo/g

" Con confirmación
:%s/viejo/nuevo/gc

" Solo en selección visual (presiona : en visual mode)
:'<,'>s/viejo/nuevo/g

" Case insensitive
:%s/viejo/nuevo/gi

" Reemplazar palabra exacta (no substring)
:%s/\<viejo\>/nuevo/g

" Reemplazar en múltiples archivos abiertos
:bufdo %s/viejo/nuevo/ge | update
```

> **Truco:** `cgn` — cambia la siguiente ocurrencia de la búsqueda activa. Luego `.` repite hacia la siguiente. Ultra rápido para refactor.

---

## Jump List y Change List

| Atajo | Acción |
|-------|--------|
| `Ctrl-o` | Saltar atrás (jump list) |
| `Ctrl-i` | Saltar adelante (jump list) |
| `g;` | Ir al cambio anterior (change list) |
| `g,` | Ir al cambio siguiente (change list) |

> **Útil:** Vas a una definición con `gd`, exploras, vuelves con `Ctrl-o`.

---

## Quickfix — Navegar errores y búsquedas

| Atajo | Acción |
|-------|--------|
| `<leader>xq` | Abrir Quickfix list |
| `<leader>xl` | Abrir Location list |
| `]q` / `[q` | Siguiente / anterior item en quickfix |
| `:cdo s/viejo/nuevo/g` | Aplicar sustitución a todos los items del quickfix |

> **Truco pro:** Haz un grep con `<leader>fg`, selecciona resultados, son tu quickfix — edita todos con `:cdo`.

---

## Indentación y Formateo

| Atajo | Acción |
|-------|--------|
| `>>` / `<<` | Indentar / des-indentar línea |
| `>` / `<` (visual) | Indentar / des-indentar selección |
| `=` (visual) | Auto-indentar selección |
| `gg=G` | Auto-indentar archivo completo |
| `<leader>cf` | Formatear con LSP/Prettier/etc |

---

## Números y Incremento

| Atajo | Acción |
|-------|--------|
| `Ctrl-a` | Incrementar número bajo cursor |
| `Ctrl-x` | Decrementar número bajo cursor |
| `10Ctrl-a` | Incrementar en 10 |
| `g Ctrl-a` | (visual) Incremento secuencial: 1, 2, 3... |

> **Truco:** Selecciona visualmente varias líneas con el mismo número, `g Ctrl-a` las enumera en secuencia.

---

## Splits y Layout eficiente

| Atajo | Acción |
|-------|--------|
| `<C-w>=` | Igualar tamaño de todos los splits |
| `<C-w>_` | Maximizar split horizontalmente |
| `<C-w>\|` | Maximizar split verticalmente |
| `<C-w>r` | Rotar ventanas |
| `<C-w>T` | Mover split a nuevo tab |
| `<C-w>x` | Intercambiar con ventana adyacente |

---

## Folding (plegar código)

| Atajo | Acción |
|-------|--------|
| `za` | Toggle fold bajo cursor |
| `zc` / `zo` | Cerrar / abrir fold |
| `zM` | Cerrar todos los folds |
| `zR` | Abrir todos los folds |
| `zj` / `zk` | Siguiente / anterior fold |

---

## Comandos de Línea Útiles

```vim
" Ordenar líneas seleccionadas
:'<,'>sort

" Borrar líneas duplicadas
:sort u

" Borrar líneas en blanco
:g/^$/d

" Borrar líneas que contienen patrón
:g/console.log/d

" Ejecutar comando de shell e insertar output
:r !date

" Ver diferencia con versión guardada en disco
:w !diff % -
```

---

## Navegación en Código (LSP)

| Atajo | Acción |
|-------|--------|
| `gd` → `Ctrl-o` | Ir a definición y volver |
| `<leader>ss` | Buscar símbolo en archivo |
| `<leader>sS` | Buscar símbolo en workspace |
| `<leader>xd` | Todos los diagnósticos del proyecto |
| `<leader>xe` | Solo errores |

---

## Snacks — Features Ocultos

| Atajo | Acción |
|-------|--------|
| `<leader>n` | Notificaciones recientes |
| `<leader>bd` | Borrar buffer sin cerrar split |
| `<leader>bo` | Cerrar todos los buffers menos el actual |
| `z.` | Scroll suave al cursor (mini-animate) |

---

## Trucos de Selección Visual

```
# Seleccionar hasta fin de línea (sin newline)
v$h

# Seleccionar bloque de función completa
vaf   (requiere treesitter)

# Expandir selección con treesitter
<leader> mientras estás en visual mode
```

| Atajo | Acción |
|-------|--------|
| `gv` | Reseleccionar última selección visual |
| `o` (en visual) | Mover cursor al otro extremo de la selección |

---

## TypeScript / PHP — Específicos

| Atajo | Acción |
|-------|--------|
| `<leader>co` | Organizar imports (TS) |
| `<leader>cR` | Restart LSP |
| `<leader>ci` | Info del LSP activo |
| `]e` / `[e` | Navegar errores de tipo |

> **Truco:** `:LspInfo` para ver qué servidores están activos en el archivo actual.

---

## Clipboard — Sistema

Agregar en config si aún no funciona `"+y`:

```lua
vim.opt.clipboard = "unnamedplus"  -- Sincroniza con portapapeles del sistema
```

Con esto `y` y `p` usan el clipboard del sistema directamente.

---

## Miscelánea Productividad

| Atajo / Comando | Acción |
|-----------------|--------|
| `J` | Unir línea siguiente a la actual |
| `gJ` | Unir sin agregar espacio |
| `xp` | Intercambiar char con el siguiente |
| `ddp` | Mover línea una posición abajo |
| `ddkP` | Mover línea una posición arriba |
| `:earlier 5m` | Deshacer al estado de hace 5 minutos |
| `:later 30s` | Rehacer al estado de hace 30 segundos |
| `q:` | Historial de comandos |
| `q/` | Historial de búsquedas |
