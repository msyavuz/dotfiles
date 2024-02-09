export PATH=$HOME/.cargo/bin:$PATH
export EDITOR=nvim
export T_SESSION_NAME_INCLUDE_PARENT="false"
export PATH="$HOME/.local/bin:$PATH"
export QT_QPA_PLATFORMTHEME=qt5ct
export PATH="$HOME/go/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
