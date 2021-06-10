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
eval "$(/opt/homebrew/bin/brew shellenv)"

echo '--> Setting compiler flags for qpdf, readline, openssl, zlib'

# qpdf flags (required for PikePDF):
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/qpdf/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/qpdf/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /opt/homebrew/opt/qpdf/lib/pkgconfig"

# readline flags:
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/readline/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/readline/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /opt/homebrew/opt/readline/lib/pkgconfig"

# zlib flags
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/zlib/include"
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/zlib/lib"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /opt/homebrew/opt/zlib/lib/pkgconfig"

# openssl@1.1 flags:
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/openssl/include"
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/openssl/lib"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /opt/homebrew/opt/openssl/lib/pkgconfig"

echo '--> Setting PATH'
PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
PATH="$PYENV_ROOT/bin:$PATH"
PATH="$HOME/.poetry/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
export PATH
