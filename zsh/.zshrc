# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme and Plugins
ZSH_THEME="robbyrussell"

# Zsh plugins
plugins=(git laravel zsh-interactive-cd docker docker-compose rust git-flow)

source $ZSH/oh-my-zsh.sh

# Powerlevel10k & Plugins
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# SSH agent para GitHub
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

# Solo inicia tmux si es una sesión interactiva, tmux existe y no estamos ya dentro de una sesión
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [ -z "$TMUX" ]; then
    exec tmux
fi

