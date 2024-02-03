# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
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



# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

unset rc

lastcmd() { LASTCMD=$(history 1 | cut -c8-); echo -ne "\e]2;$LASTCMD\a\e]1;$LASTCMD\a"; }
PROMPT_COMMAND=lastcmd
eval "$(starship init bash)"
eval "$(zoxide init bash)"

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

alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export npm_config_prefix="${HOME}/.npm-packages"

NPM_PACKAGES="${HOME}/.npm-packages"

export PATH="$PATH:$NPM_PACKAGES/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

source /home/msyavuz/.profile
