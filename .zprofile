#!/usr/bin/env zsh
echo '--> Configuring profile path [.zprofile]'

UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # On Intel macOS, this script installs to /usr/local only
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
