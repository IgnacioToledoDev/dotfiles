# Plugins de TMUX

Gestor: **TPM** (Tmux Plugin Manager) — instalado en `tmux/plugins/tpm`.

## Plugins incluidos

| Plugin | Repo | Descripción |
|--------|------|-------------|
| tmux-kanagawa | [Nybkox/tmux-kanagawa](https://github.com/Nybkox/tmux-kanagawa) | Tema visual + barra de estado |

### Widgets activos (tmux-kanagawa)

| Widget | Muestra |
|--------|---------|
| `git` | Rama actual del directorio |
| `cpu-usage` | % uso de CPU |
| `ram-usage` | % uso de RAM |

Tema: `dragon`.

---

## Instalación desde cero

### 1. Instalar TPM

TPM viene como submodule. Inicializarlo:

```bash
git submodule update --init --recursive
```

O clonarlo manualmente a donde tmux lo espera:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 2. Instalar plugins

Los plugins **no están en el repo** — TPM los descarga desde GitHub al instalarlos.

Abrir tmux y ejecutar:

```
prefix + I
```

> `prefix` = `Ctrl+a`. TPM clona e instala todos los plugins definidos en `.tmux.conf`, incluyendo `tmux-kanagawa`.

### 3. Recargar config (si es necesario)

```bash
tmux source ~/.tmux.conf
```

---

## Agregar nuevos plugins

1. Agregar en `.tmux.conf`:

```bash
set -g @plugin 'usuario/nombre-plugin'
```

2. Instalar con `prefix + I`.

## Actualizar plugins

```
prefix + U
```

## Desinstalar plugin

1. Eliminar la línea `set -g @plugin` en `.tmux.conf`.
2. Ejecutar `prefix + alt + u`.
