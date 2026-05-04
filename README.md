# dotfiles

Configuraciones personales para el entorno de desarrollo.

## Contenido

| Herramienta | Descripción | Docs |
|-------------|-------------|------|
| [tmux](./tmux/.tmux.conf) | Multiplexor de terminal | [TMUX.md](https://github.com/IgnacioToledoDev/dotfiles/blob/main/tmux/TMUX.md) |
| nvim | Editor Neovim | Próximamente |

## Uso

Clona el repo y enlaza (symlink) los archivos que necesites a sus ubicaciones correspondientes.

```bash
git clone git@github.com:IgnacioToledoDev/dotfiles.git ~/dotfiles
```

### tmux

```bash
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```
