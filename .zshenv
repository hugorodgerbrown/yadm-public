echo '--> Setting up environment variables'
export EDITOR="subl -w"
export HOMEBREW_AUTO_UPDATE_SECS=86400
export NVM_DIR="$HOME/.nvm"
export PIPENV_VENV_IN_PROJECT=1
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_VENV_IN_PROJECT=1

# expands to export various HOMEBREW_* vars
eval "$(/opt/homebrew/bin/brew shellenv)"

# readline flags:
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig $PKG_CONFIG_PATH"

# zlib flags
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/zlib/include"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/zlib/lib"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig"

# openssl@1.1 flags:
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openssl@1.1/include"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/openssl@1.1/lib"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /usr/local/opt/openssl@1.1/lib/pkgconfig"

echo '--> Setting PATH'
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/opt/gdal2/bin:$PATH"
PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
PATH="$PYENV_ROOT/bin:$PATH"
PATH="$HOME/.poetry/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH
