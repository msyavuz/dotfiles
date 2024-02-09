# Lazy-load antidote and generate the static load file only when needed
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins

if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    (
        source ${ZDOTDIR:-~}/.antidote/antidote.zsh
        antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
    )
fi

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

source ${zsh_plugins}.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Aliases
alias vi=nvim
alias vim=nvim
alias cd=z
alias ls="eza --icons=always"


alias dnfin="sudo dnf install"
alias dnfse="sudo dnf search"

alias pacin="sudo pacman -S"
alias pacre="sudo pacman -Rs"
alias yain="yay -S"
alias yare="yay -Rs"

alias ta=tmux_attach


export npm_config_prefix="${HOME}/.npm-packages"

NPM_PACKAGES="${HOME}/.npm-packages"

export PATH="$PATH:$NPM_PACKAGES/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

source "${HOME}/.profile"
