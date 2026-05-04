# dotfiles

Configuraciones personales para el entorno de desarrollo.

## Contenido

| Herramienta | Descripción | Docs |
|-------------|-------------|------|
| [tmux](./tmux/.tmux.conf) | Multiplexor de terminal | [TMUX.md](https://github.com/IgnacioToledoDev/dotfiles/blob/main/tmux/TMUX.md) · [PLUGINS.md](https://github.com/IgnacioToledoDev/dotfiles/blob/main/tmux/plugins/PLUGINS.md) |
| [zsh](./zsh/.zshrc) | Shell con Oh My Zsh + Powerlevel10k | [ZSH.md](https://github.com/IgnacioToledoDev/dotfiles/blob/main/zsh/ZSH.md) |
| nvim | Editor Neovim | Próximamente |

## Uso

Clona el repo y enlaza (symlink) los archivos que necesites a sus ubicaciones correspondientes.

```bash
git clone git@github.com:IgnacioToledoDev/dotfiles.git ~/dotfiles
```

### tmux

**1. Enlazar la config**

```bash
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

**2. Instalar TPM (gestor de plugins)**

TPM viene como submodule. Inicializarlo con:

```bash
git -C ~/dotfiles submodule update --init --recursive
```

O clonarlo manualmente:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

**3. Instalar los plugins**

Abrir tmux y ejecutar `prefix + I` (`Ctrl+a` + `I`). TPM descarga e instala todos los plugins definidos en `.tmux.conf`.

### zsh

**1. Enlazar la config**

```bash
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
```

**2. Instalar dependencias**

```bash
brew install powerlevel10k zsh-syntax-highlighting
```

**3. Recargar la shell**

```bash
source ~/.zshrc
```

Ver [ZSH.md](./zsh/ZSH.md) para la guía completa de instalación y referencia de la configuración.
