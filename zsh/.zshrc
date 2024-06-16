source "$HOME/.antidote/antidote.zsh"

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

source /usr/share/nvm/init-nvm.sh
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
alias shad="pnpm dlx shadcn-ui@latest"
alias anim="hyprctl keyword animations:enabled"

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

# pnpm
export PNPM_HOME="/home/msyavuz/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

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
. /opt/asdf-vm/asdf.sh

eval "$(fzf --zsh)"

# Python virtualenv auto activate
eval "$(pyenv virtualenv-init -)"
export SUPERSET_CONFIG_PATH=/home/msyavuz/Repos/apache_secretset/superset_config.py

eval "$(starship init zsh)"
