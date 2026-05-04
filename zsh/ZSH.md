# ZSH

Configuración personal de Zsh basada en [Oh My Zsh](https://ohmyz.sh/) con el tema [Powerlevel10k](https://github.com/romkatv/powerlevel10k).

## Requisitos

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (tema)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Homebrew](https://brew.sh/)
- Node.js 20 (via Homebrew)

## Instalación

**1. Instalar Oh My Zsh**

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**2. Instalar Powerlevel10k**

```bash
brew install powerlevel10k
```

**3. Instalar zsh-syntax-highlighting**

```bash
brew install zsh-syntax-highlighting
```

**4. Enlazar la configuración**

```bash
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
```

**5. Recargar la shell**

```bash
source ~/.zshrc
```

Al primer inicio, Powerlevel10k lanza su wizard de configuración. Si no arranca automáticamente:

```bash
p10k configure
```

## Actualización

Para actualizar Oh My Zsh y sus plugins:

```bash
omz update
```

Para actualizar Powerlevel10k y zsh-syntax-highlighting:

```bash
brew upgrade powerlevel10k zsh-syntax-highlighting
```

## Estructura del archivo `.zshrc`

### Instant prompt (Powerlevel10k)

```zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
```

Habilita la carga instantánea del prompt antes de que termine de inicializarse la shell, evitando el parpadeo en terminales lentas.

### Tema y plugins de Oh My Zsh

```zsh
ZSH_THEME="robbyrussell"
plugins=(git laravel zsh-interactive-cd docker docker-compose rust git-flow)
```

| Plugin | Descripción |
|--------|-------------|
| `git` | Aliases y funciones para git |
| `laravel` | Aliases para Artisan y Laravel |
| `zsh-interactive-cd` | Navegación interactiva con `cd` |
| `docker` | Autocompletado para Docker |
| `docker-compose` | Autocompletado para Docker Compose |
| `rust` | Aliases y autocompletado para Cargo/Rust |
| `git-flow` | Aliases para git-flow |

### PATH y herramientas

| Entrada al PATH | Propósito |
|-----------------|-----------|
| `/opt/homebrew/opt/node@20/bin` | Node.js 20 via Homebrew |
| `~/.composer/vendor/bin` | Binarios globales de Composer (PHP) |
| `VS Code.app/.../bin` | Comando `code` en la terminal |
| `~/Library/Python/3.11/bin` | Binarios de pip instalados por el usuario |
| `~/.local/bin` | Binarios locales del usuario |
| `~/.console-ninja/.bin` | Console Ninja (debugging) |

### Google Cloud SDK

```zsh
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
fi
```

Carga el SDK de GCloud si existe en `~/Downloads/google-cloud-sdk`. Los bloques `if` evitan errores si no está instalado.

### Tmux autostart

```zsh
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [ -z "$TMUX" ]; then
    exec tmux
fi
```

Inicia tmux automáticamente al abrir una sesión interactiva, siempre que no estemos ya dentro de una sesión tmux existente.
