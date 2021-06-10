echo '--> Setting environment variables'
export EDITOR="subl -w"
export HOMEBREW_AUTO_UPDATE_SECS=86400
export HOMEBREW_BUNDLE_FILE=$HOME/.Brewfile-dev
export NVM_DIR="$HOME/.nvm"
export PIPENV_VENV_IN_PROJECT=1
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VENV_IN_PROJECT=1
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# expands to export various HOMEBREW_* vars
eval "$(/usr/local/bin/brew shellenv)"

echo '--> Setting compiler flags for qpdf, readline, openssl, zlib'

# qpdf flags (required for PikePDF):
export LDFLAGS="$LDFLAGS -L/usr/local/opt/qpdf/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/qpdf/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /usr/local/opt/qpdf/lib/pkgconfig"

# readline flags:
export LDFLAGS="$LDFLAGS -L/usr/local/opt/readline/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/readline/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /usr/local/opt/readline/lib/pkgconfig"

# zlib flags
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/zlib/include"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/zlib/lib"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig"

# openssl@1.1 flags:
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openssl/include"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/openssl/lib"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /usr/local/opt/openssl/lib/pkgconfig"

echo '--> Setting PATH'
PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
PATH="$PYENV_ROOT/bin:$PATH"
PATH="$HOME/.poetry/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
# PATH="/usr/local/opt:$PATH"
export PATH
