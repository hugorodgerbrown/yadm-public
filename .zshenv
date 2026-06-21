#!/usr/bin/env zsh
echo '--> Setting environment variables [.zshenv]'

export EDITOR="subl -w"
export HOMEBREW_AUTO_UPDATE_SECS=86400
export NVM_DIR="$HOME/.nvm"
# blank format suppresses output
# export DIRENV_LOG_FORMAT=

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

# PATH moved to bottom of .zshrc to ensure it's the last one
echo '<-- /Setting environment variables [.zshenv]'
