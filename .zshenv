#!/usr/bin/env zsh
echo '--> Setting environment variables [.zshenv]'

export EDITOR="subl -w"
export HOMEBREW_AUTO_UPDATE_SECS=86400
export NVM_DIR="$HOME/.nvm"
export PIPENV_VENV_IN_PROJECT=1
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_VENV_IN_PROJECT=1
# blank format suppresses output
export DIRENV_LOG_FORMAT=

# export PYPI_USERNAME=__token__
# echo ".. inject secrets from 1Password"
# export PYPI_PASSWORD=$(echo "{{ op://personal/pypi/api token}}" | op inject)

# ==== taken from the Homebrew install script
echo " .. run homebrew shellenv"
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # On Intel macOS, this script installs to /usr/local only
    eval "$(/usr/local/bin/brew shellenv)"
fi
# /==== taken from the Homebrew install script

echo -n ' .. set compiler flags: '
for FLAG in qpdf readline zlib openssl pango glib libxmlsec1
do
    export LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/$FLAG/lib"
    export CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/$FLAG/include"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH $HOMEBREW_PREFIX/opt/$FLAG/lib/pkgconfig"
    echo -n "$FLAG "
done
echo ""

# moved to bottom of .zshrc to ensure it's the last one
# echo " .. set PATH"
# PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
# PATH="$PYENV_ROOT/bin:$PATH"
# PATH="$HOME/.poetry/bin:$PATH"
# PATH="$HOME/.local/bin:$PATH"
# PATH="$HOMEBREW_PREFIX/bin:$PATH"
# export PATH
# echo $PATH

echo '<-- /Setting environment variables [.zshenv]'
