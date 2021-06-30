#!/bin/zsh
echo '--> Setting environment variables'
export EDITOR="subl -w"
export HOMEBREW_AUTO_UPDATE_SECS=86400
export HOMEBREW_BUNDLE_FILE=$HOME/.Brewfile-dev
export NVM_DIR="$HOME/.nvm"
export PIPENV_VENV_IN_PROJECT=1
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VENV_IN_PROJECT=1
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# ==== taken from the Homebrew install script
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # On Intel macOS, this script installs to /usr/local only
    eval "$(/usr/local/bin/brew shellenv)"
fi
# /==== taken from the Homebrew install script

echo '... Setting compiler flags for qpdf, readline, openssl, zlib'
# qpdf flags (required for PikePDF):
export LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/qpdf/lib"
export CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/qpdf/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH $HOMEBREW_PREFIX/opt/qpdf/lib/pkgconfig"

# readline flags:
export LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/readline/lib"
export CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/readline/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH $HOMEBREW_PREFIX/opt/readline/lib/pkgconfig"

# zlib flags
export CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/zlib/include"
export LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/zlib/lib"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH $HOMEBREW_PREFIX/opt/zlib/lib/pkgconfig"

# openssl@1.1 flags:
export CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/openssl/include"
export LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/openssl/lib"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH $HOMEBREW_PREFIX/opt/openssl/lib/pkgconfig"

echo '... Setting PATH'
PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
PATH="$PYENV_ROOT/bin:$PATH"
PATH="$HOME/.poetry/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOMEBREW_PREFIX/bin:$PATH"
export PATH
