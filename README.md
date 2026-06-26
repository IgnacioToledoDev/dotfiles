# dotfiles

Personal development environment configuration for Arch Linux.

***Language***
- 🇺🇸 English
- [🇪🇸 Español](./README.es.md)

![Qtile](.screenshots/qtile-view.png)

![Qtile Fastfetch](.screenshots/qtile-fastfetch.png)

## Contents

| Tool | Description | Docs |
|------|-------------|------|
| [alacritty](./alacritty/alacritty.toml) | Terminal with Ayu Dark theme and JetBrainsMono | — |
| [claude](./claude/settings.json) | Claude Code CLI — caveman, superpowers and frontend-design plugins | [README.md](./claude/README.md) |
| [fastfetch](./fastfetch/config.jsonc) | System info with ASCII art and Catppuccin colors | [README.md](./fastfetch/README.md) |
| [qtile](./qtile/config.py) | Window manager with custom bar and multiple themes | [README.md](./qtile/README.md) |
| [nvim](./nvim/init.lua) | Neovim editor with LazyVim and Ayu Dark theme | [README.md](./nvim/README.md) · [Shortcuts.md](./nvim/Shortcuts.md) |
| [tmux](./tmux/.tmux.conf) | Terminal multiplexer with TPM | [TMUX.md](./tmux/TMUX.md) |
| [zsh](./zsh/.zshrc) | Shell with Oh My Zsh, Powerlevel10k and SSH agent | [ZSH.md](./zsh/ZSH.md) |
| [wallpapers](./wallpapers/) | Desktop wallpapers | — |

## Installation

Clone the repo:

```bash
git clone git@github.com:IgnacioToledoDev/dotfiles.git ~/dotfiles
```

Then link or copy the module folder you need to its corresponding location.

---

### fastfetch

**Dependencies (Arch):**

```bash
sudo pacman -S fastfetch
```

**Copy the folder:**

```bash
cp -r ~/dotfiles/fastfetch ~/.config/fastfetch
```

---

### alacritty

```bash
mkdir -p ~/.config/alacritty
ln -s ~/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
```

**Ayu Dark** theme with **JetBrainsMono Nerd Font Bold** (size 10.5) and 70% window opacity.

---

### qtile

**Dependencies (Arch):**

```bash
sudo pacman -S qtile swaybg cbatticon volumeicon playerctl
yay -S nerd-fonts-ubuntu-mono
pip install psutil
```

**Link the config:**

```bash
ln -s ~/dotfiles/qtile ~/.config/qtile
```

**Wallpaper:** `autostart.sh` loads it with `swaybg`. Update the path in that file if you store the wallpaper elsewhere:

```bash
# qtile/autostart.sh
swaybg -i ~/dotfiles/wallpapers/background.jpeg -m fill &
```

**Change theme:** edit `qtile/config.json` with any theme name from `qtile/themes/`:

```json
{ "theme": "ayu" }
```

Available themes: `ayu`, `dracula`, `nord`, `nord-wave`, `onedark`, `rosepine`, `material-ocean`, `material-darker`, `monokai-pro`, `dark-grey`.

---

### nvim

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```

LazyVim installs all plugins automatically on first launch. Active theme is **Ayu Dark**, consistent with Alacritty and Qtile.

```bash
nvim
```

---

### tmux

**Link the config:**

```bash
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

**Initialize TPM** (included as submodule):

```bash
git -C ~/dotfiles submodule update --init --recursive
```

**Install plugins:** open tmux and run `prefix + I` (`Ctrl+a I`).

---

### claude

**Dependencies:**

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code)
- [mise](https://mise.jdx.dev/) with Node.js ≥ 18

**Install:**

```bash
bash ~/dotfiles/claude/install.sh
```

See [claude/README.md](./claude/README.md) for details.

---

### zsh

**Dependencies (Arch):**

```bash
sudo pacman -S zsh
yay -S oh-my-zsh-git powerlevel10k zsh-syntax-highlighting
```

**Link the config:**

```bash
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
source ~/.zshrc
```

Includes automatic SSH agent startup for GitHub authentication. Requires a key at `~/.ssh/id_ed25519`.
