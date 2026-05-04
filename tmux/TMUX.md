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

## Paneles

### Dividir pantalla

| Atajo | Acción |
|-------|--------|
| `prefix` + `\|` | Dividir panel **horizontal** (izquierda / derecha) |
| `prefix` + `-` | Dividir panel **vertical** (arriba / abajo) |

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

## Referencia rápida

```
Ctrl+a  →  prefijo

Paneles:
  |   dividir horizontal
  -   dividir vertical
  h/j/k/l   navegar (vim)
  H/J/K/L   redimensionar
  m   zoom toggle

Copia:
  prefix+[  entrar modo copia
  v   seleccionar
  y   copiar
```
