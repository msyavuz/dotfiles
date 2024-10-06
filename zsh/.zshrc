export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source $HOME/.antidote/antidote.zsh

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# source /usr/share/nvm/init-nvm.sh
function tmux_attach() {
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
alias dnfin="sudo dnf install"
alias dnfre="sudo dnf remove"
alias ta=tmux_attach
alias tk="tmux kill-server"
alias shad="pnpm dlx shadcn-ui@latest"
alias anim="hyprctl keyword animations:enabled"
alias time="/usr/bin/time -f '%E real,%U user,%S sys'"
alias unstow="stow -D"
alias sysen="sudo systemctl enable"
alias sysdis="sudo systemctl disable"
alias sysstart="sudo systemctl start"
alias sysstop="sudo systemctl stop"
alias dcup="docker compose up"
alias dcdown="docker compose down"

autoload -Uz compinit && compinit

NPM_PACKAGES="${HOME}/.npm-packages"

export PATH="$PATH:$NPM_PACKAGES/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

antidote load

# Load Angular CLI autocompletion.
source <(ng completion script)

eval "$(zoxide init zsh)"

source "${HOME}/.profile"


HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-min-size 100 8

eval "$(fzf --zsh)"

# Python virtualenv auto activate
eval "$(pyenv virtualenv-init -)"
export SUPERSET_CONFIG_PATH=/home/msyavuz/Work/apache_secretset/superset_config.py

eval "$(starship init zsh)"

