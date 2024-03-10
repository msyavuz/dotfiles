export PATH=$HOME/.cargo/bin:$PATH
export EDITOR=nvim
export T_SESSION_NAME_INCLUDE_PARENT="false"
export PATH="$HOME/.local/bin:$PATH"
export QT_QPA_PLATFORMTHEME=qt5ct
export PATH="$HOME/go/bin:$PATH"

export GTK_USE_PORTAL=0

export PATH="$HOME/.local/bin/scripts:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export OLLAMA_MODELS="$HOME/.ollama-models"
export PATH="$HOME/.dotnet/tools:$PATH"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
. "$HOME/.cargo/env"
