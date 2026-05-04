# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme and Plugins
ZSH_THEME="robbyrussell"
plugins=(git laravel zsh-interactive-cd docker docker-compose rust git-flow)

source $ZSH/oh-my-zsh.sh

# --- Paths & Tooling ---

# Homebrew & Node
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

# Powerlevel10k & Plugins
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Composer, VS Code, Python & Local bin
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/Library/Python/3.11/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.console-ninja/.bin:$PATH"

# Google Cloud SDK (Usando $HOME para mayor portabilidad)
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"; fi

# --- Tmux Autostart ---
# Solo inicia tmux si es una sesión interactiva, tmux existe y no estamos ya dentro de una sesión
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [ -z "$TMUX" ]; then
    exec tmux
fi

