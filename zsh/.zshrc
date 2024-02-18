source "$HOME/.antidote/antidote.zsh"

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

tmux_attach() {
    if [[ -n $(pgrep tmux) ]]; then
        tmux attach-session
    else
        tmux
    fi
}

# Aliases
alias vi=nvim
alias vim=nvim
alias cd=z
alias ls="eza --icons=always"
alias lg="lazygit"
alias pacin="sudo pacman -S"
alias pacre="sudo pacman -Rs"
alias yain="yay -S"
alias yare="yay -Rs"
alias ta=tmux_attach
alias tk="tmux kill-server"

autoload -Uz compinit
compinit

export npm_config_prefix="${HOME}/.npm-packages"

NPM_PACKAGES="${HOME}/.npm-packages"

export PATH="$PATH:$NPM_PACKAGES/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"


antidote load
eval "$(starship init zsh)"
# Load Angular CLI autocompletion.
source <(ng completion script)

eval "$(zoxide init zsh)"

source "${HOME}/.profile"


