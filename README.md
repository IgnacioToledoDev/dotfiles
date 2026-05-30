# dotfiles

Configuraciones personales para el entorno de desarrollo en Arch Linux.

![Qtile](.screenshots/qtile-view.png)

![Qtile Fastfetch](.screenshots/qtile-fastfetch.png)

## Contenido

| Herramienta | Descripción | Docs |
|-------------|-------------|------|
| [alacritty](./alacritty/alacritty.toml) | Terminal con tema Ayu Dark y JetBrainsMono | — |
| [claude](./claude/settings.json) | Claude Code CLI — plugins caveman, superpowers y frontend-design | [README.md](./claude/README.md) |
| [fastfetch](./fastfetch/config.jsonc) | System info con ASCII art y colores Catppuccin | [README.md](./fastfetch/README.md) |
| [qtile](./qtile/config.py) | Window manager con barra personalizada y múltiples temas | [README.md](./qtile/README.md) |
| [nvim](./nvim/init.lua) | Editor Neovim con LazyVim y tema Ayu Dark | [README.md](./nvim/README.md) · [Shortcuts.md](./nvim/Shortcuts.md) |
| [tmux](./tmux/.tmux.conf) | Multiplexor de terminal con TPM | [TMUX.md](./tmux/TMUX.md) |
| [zsh](./zsh/.zshrc) | Shell con Oh My Zsh, Powerlevel10k y agente SSH | [ZSH.md](./zsh/ZSH.md) |
| [wallpapers](./wallpapers/) | Fondos de pantalla del escritorio | — |

## Instalación

Clona el repo:

```bash
git clone git@github.com:IgnacioToledoDev/dotfiles.git ~/dotfiles
```

Luego copia la carpeta del módulo que necesites a su ubicación correspondiente.

---

### fastfetch

**Dependencias (Arch):**

```bash
sudo pacman -S fastfetch
```

**Copiar la carpeta:**

```bash
cp -r ~/dotfiles/fastfetch ~/.config/fastfetch
```

---

### alacritty

```bash
mkdir -p ~/.config/alacritty
ln -s ~/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
```

Tema **Ayu Dark** con fuente **JetBrainsMono Nerd Font Bold** (tamaño 10.5) y opacidad de ventana al 70%.

---

### qtile

**Dependencias (Arch):**

```bash
sudo pacman -S qtile swaybg cbatticon volumeicon playerctl
yay -S nerd-fonts-ubuntu-mono
pip install psutil
```

**Enlazar la config:**

```bash
ln -s ~/dotfiles/qtile ~/.config/qtile
```

**Wallpaper:** el script `autostart.sh` carga el fondo con `swaybg`. Actualiza la ruta en ese archivo si guardas el wallpaper en un lugar distinto:

```bash
# qtile/autostart.sh
swaybg -i ~/dotfiles/wallpapers/background.jpeg -m fill &
```

**Cambiar tema:** edita `qtile/config.json` con el nombre de cualquier tema de `qtile/themes/`:

```json
{ "theme": "ayu" }
```

Temas disponibles: `ayu`, `dracula`, `nord`, `nord-wave`, `onedark`, `rosepine`, `material-ocean`, `material-darker`, `monokai-pro`, `dark-grey`.

---

### nvim

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```

LazyVim instala todos los plugins automáticamente en el primer arranque. El tema activo es **Ayu Dark**, coherente con Alacritty y Qtile.

```bash
nvim
```

---

### tmux

**Enlazar la config:**

```bash
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

**Inicializar TPM** (viene como submódulo):

```bash
git -C ~/dotfiles submodule update --init --recursive
```

**Instalar plugins:** abrir tmux y ejecutar `prefix + I` (`Ctrl+a I`).

---

### claude

**Dependencias:**

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code)
- [mise](https://mise.jdx.dev/) con Node.js ≥ 18

**Instalar:**

```bash
bash ~/dotfiles/claude/install.sh
```

Ver [claude/README.md](./claude/README.md) para más detalles.

---

### zsh

**Dependencias (Arch):**

```bash
sudo pacman -S zsh
yay -S oh-my-zsh-git powerlevel10k zsh-syntax-highlighting
```

**Enlazar la config:**

```bash
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
source ~/.zshrc
```

El archivo incluye arranque automático del agente SSH para autenticación con GitHub. Requiere tener una clave en `~/.ssh/id_ed25519`.
