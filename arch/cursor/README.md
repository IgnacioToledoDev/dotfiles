# Cursor themes

Backups of cursor themes used on Arch (Omarchy / Hyprland).

| Theme | Package | Notes |
|---|---|---|
| `catppuccin-mocha-dark-cursors` | `catppuccin-cursors-mocha` (AUR) | Current |
| `vimix-kanagawa-cursors-wave` | `vimix-kanagawa-cursors` (AUR) | Previous |
| `Yaru` (cursors only) | `yaru-icon-theme` | Ubuntu cursor |

Install by package, or copy a theme directory to `~/.local/share/icons/`.

Apply in `~/.config/hypr/envs.conf` (XCURSOR_THEME / HYPRCURSOR_THEME), GTK 3/4 `settings.ini`,
`gsettings set org.gnome.desktop.interface cursor-theme <name>` and `hyprctl setcursor <name> 24`.
