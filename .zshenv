#!/usr/bin/env zsh
echo '--> Setting environment variables [.zshenv]'

export EDITOR="subl -w"
export HOMEBREW_AUTO_UPDATE_SECS=86400
export HOMEBREW_NO_ASK=1
export NVM_DIR="$HOME/.nvm"
# blank format suppresses output
export DIRENV_LOG_FORMAT=

# Keep fastembed's 66MB ONNX model out of $TMPDIR, which macOS reaps — a reap
# mid-download leaves a truncated model that fails every later load. memex now
# defaults to this same path in its own source, so this export only covers any
# *other* fastembed consumer; it is not what fixes memex. Note that Claude Code
# hooks run under /bin/sh and never source this file, which is exactly why the
# fix had to live in the code rather than here.
export FASTEMBED_CACHE_PATH="$HOME/.cache/fastembed"

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

# Claude credentials are deliberately NOT exported here. Shell init is sourced by
# every subprocess, so an exported key leaks into shell snapshots and transcripts
# and shadows the Keychain login. The Claude Code OAuth token lives in the macOS
# Keychain (service: memex-claude-oauth) and is read at hook-run time by the
# SessionEnd hook. Interactive Claude Code uses the Desktop app's Keychain login.
#
# Same rule for the Hugging Face token, for the same reason — no `export HF_TOKEN`
# here. It lives in ~/.cache/huggingface/token (mode 600), which huggingface_hub
# reads on its own, and only when it actually authenticates a download. That beats
# a Keychain read wired into the memex hooks: UserPromptSubmit fires on every
# prompt, and the token is needed roughly once per machine.

# PATH moved to bottom of .zshrc to ensure it's the last one
echo '<-- /Setting environment variables [.zshenv]'
