# ZSH

Configuración personal de Zsh basada en [Oh My Zsh](https://ohmyz.sh/) con el tema [Powerlevel10k](https://github.com/romkatv/powerlevel10k).

## Requisitos

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (tema)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Homebrew](https://brew.sh/)

## Instalación

**1. Instalar Oh My Zsh**

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**2. Instalar dependencias**

```bash
brew install powerlevel10k zsh-syntax-highlighting
```

**3. Enlazar la configuración**

```bash
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
```

**4. Recargar la shell**

```bash
source ~/.zshrc
```

Al primer inicio, Powerlevel10k lanza su wizard de configuración. Si no arranca automáticamente:

```bash
p10k configure
```

## Actualización

```bash
omz update
brew upgrade powerlevel10k zsh-syntax-highlighting
```

## Plugins

| Plugin | Descripción |
|--------|-------------|
| `git` | Aliases y funciones para git |
| `laravel` | Aliases para Artisan y Laravel |
| `zsh-interactive-cd` | Navegación interactiva con `cd` |
| `docker` | Autocompletado para Docker |
| `docker-compose` | Autocompletado para Docker Compose |
| `rust` | Aliases y autocompletado para Cargo/Rust |
| `git-flow` | Aliases para git-flow |
