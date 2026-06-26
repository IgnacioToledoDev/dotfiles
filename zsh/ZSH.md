# ZSH

Personal Zsh config based on [Oh My Zsh](https://ohmyz.sh/) with the [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme.

***Language***
- 🇺🇸 English
- [🇪🇸 Español](./ZSH.es.md)

## Requirements

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (theme)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Homebrew](https://brew.sh/)

## Installation

**1. Install Oh My Zsh**

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**2. Install dependencies**

```bash
brew install powerlevel10k zsh-syntax-highlighting
```

**3. Link the config**

```bash
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
```

**4. Reload the shell**

```bash
source ~/.zshrc
```

On first launch, Powerlevel10k starts its configuration wizard. If it doesn't start automatically:

```bash
p10k configure
```

## Update

```bash
omz update
brew upgrade powerlevel10k zsh-syntax-highlighting
```

## Plugins

| Plugin | Description |
|--------|-------------|
| `git` | Aliases and functions for git |
| `laravel` | Aliases for Artisan and Laravel |
| `zsh-interactive-cd` | Interactive navigation with `cd` |
| `docker` | Autocompletion for Docker |
| `docker-compose` | Autocompletion for Docker Compose |
| `rust` | Aliases and autocompletion for Cargo/Rust |
| `git-flow` | Aliases for git-flow |
