# TMUX - Configuración Custom

> Repo: [IgnacioToledoDev/dotfiles](https://github.com/IgnacioToledoDev/dotfiles) — config en `tmux/.tmux.conf`

> Prefijo por defecto de tmux (`Ctrl+b`) reemplazado por **`Ctrl+a`**.
> En esta guía, `prefix` = `Ctrl+a`.

---

## Prefijo

| Atajo | Acción |
|-------|--------|
| `Ctrl+a` | Activar prefijo (reemplaza `Ctrl+b`) |

---

## Windows (Ventanas)

> Numeración empieza en **1** (`base-index 1`). Al cerrar una ventana, se renumeran automáticamente (`renumber-windows on`).

### Gestión

| Atajo | Acción |
|-------|--------|
| `prefix` + `c` | Crear ventana nueva |
| `prefix` + `,` | Renombrar ventana actual |
| `prefix` + `&` | Cerrar ventana actual (pide confirmación) |

### Navegar entre ventanas

| Atajo | Acción |
|-------|--------|
| `prefix` + `n` | Ventana **siguiente** |
| `prefix` + `p` | Ventana **anterior** |
| `prefix` + `[1-9]` | Ir a ventana por número |
| `prefix` + `w` | Lista interactiva de ventanas |

---

## Sesiones

### Gestión desde terminal

```bash
tmux new -s <nombre>       # nueva sesión con nombre
tmux ls                    # listar sesiones activas
tmux attach -t <nombre>    # reconectar a sesión existente
tmux kill-session -t <nombre>  # eliminar sesión
```

### Recuperar sesión desde dentro de tmux

| Atajo | Acción |
|-------|--------|
| `prefix` + `d` | Desconectarse (detach) — sesión sigue corriendo |
| `prefix` + `s` | Lista interactiva de sesiones (cambiar o reconectar) |
| `prefix` + `$` | Renombrar sesión actual |

> Las sesiones persisten mientras el proceso tmux esté vivo. Al reconectar: `tmux attach` (última sesión) o `tmux attach -t <nombre>`.

---

## Paneles

> Numeración empieza en **1** (`pane-base-index 1`).

### Dividir pantalla

| Atajo | Acción |
|-------|--------|
| `prefix` + `v` | Dividir panel **horizontal** (izquierda / derecha) — hereda directorio actual |
| `prefix` + `d` | Dividir panel **vertical** (arriba / abajo) — hereda directorio actual |

### Navegar entre paneles

Estilo Vim — sin flechas.

| Atajo | Dirección |
|-------|-----------|
| `prefix` + `h` | Panel de la **izquierda** |
| `prefix` + `j` | Panel de **abajo** |
| `prefix` + `k` | Panel de **arriba** |
| `prefix` + `l` | Panel de la **derecha** |

### Redimensionar paneles

Mantenible (repetible sin soltar el prefijo gracias a `-r`).

| Atajo | Acción |
|-------|--------|
| `prefix` + `H` | Expandir hacia la **izquierda** |
| `prefix` + `J` | Expandir hacia **abajo** |
| `prefix` + `K` | Expandir hacia **arriba** |
| `prefix` + `L` | Expandir hacia la **derecha** |

### Maximizar panel

| Atajo | Acción |
|-------|--------|
| `prefix` + `m` | **Zoom** al panel actual (toggle — vuelve a pulsar para restaurar) |

---

## Mouse

Mouse habilitado. Puedes:
- Hacer clic en un panel para seleccionarlo
- Arrastrar bordes de paneles para redimensionar
- Hacer scroll con la rueda para ver historial

---

## Modo copia (scroll / historial)

Navegación estilo Vim activada en modo copia.

| Paso | Atajo |
|------|-------|
| Entrar a modo copia | `prefix` + `[` |
| Moverse | `h j k l` / flechas |
| Iniciar selección | `v` |
| Copiar selección | `y` (copia al portapapeles y sale del modo) |
| Salir sin copiar | `q` |

---

## Barra de estado

| Zona | Contenido |
|------|-----------|
| Izquierda | `[nombre-sesión]` en verde |
| Derecha | Hora (`HH:MM`) en amarillo + fecha (`DD-Mes-AA`) en blanco |

---

## Plugins

Gestor: **TPM** (Tmux Plugin Manager).

| Plugin | Descripción |
|--------|-------------|
| [tmux-kanagawa](https://github.com/Nybkox/tmux-kanagawa) | Tema visual + barra de estado con widgets |

### Widgets activos en la barra (kanagawa)

| Widget | Muestra |
|--------|---------|
| `git` | Rama actual del directorio |
| `cpu-usage` | % uso de CPU |
| `ram-usage` | % uso de RAM |

Tema configurado: `dragon`.

---

## Instalación tras clonar el repo

### 1. Clonar el repositorio

```bash
git clone https://github.com/IgnacioToledoDev/dotfiles ~/.dotfiles
```

### 2. Enlazar la config

```bash
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

### 3. Instalar TPM

TPM está incluido como submodule en `tmux/plugins/tpm`. Si el directorio está vacío al clonar:

```bash
git -C ~/.dotfiles submodule update --init --recursive
```

O instalar TPM manualmente:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 4. Instalar plugins

Abrir tmux y ejecutar:

```
prefix + I
```

> `prefix` = `Ctrl+a`. TPM descarga e instala todos los plugins definidos en `.tmux.conf`.

---

## Referencia rápida

```
Ctrl+a  →  prefijo

Sesiones:
  tmux new -s <nombre>      nueva sesión
  tmux attach -t <nombre>   reconectar
  tmux ls                   listar
  prefix+d   detach (sesión sigue viva)
  prefix+s   lista interactiva de sesiones
  prefix+$   renombrar sesión

Ventanas  (inician en 1, se renumeran al cerrar):
  c   nueva ventana
  ,   renombrar
  n/p navegar siguiente/anterior
  1-9 ir a número

Paneles  (inician en 1):
  v   dividir horizontal (hereda path)
  d   dividir vertical (hereda path)
  h/j/k/l   navegar (vim)
  H/J/K/L   redimensionar
  m   zoom toggle

Copia:
  prefix+[  entrar modo copia
  v   seleccionar
  y   copiar
```
