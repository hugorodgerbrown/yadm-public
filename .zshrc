#!/usr/bin/env zsh
echo '--> Configuring shell [.zshrc]'

echo ' .. set zsh options'
source $HOME/.zsh_options

export PATH="${PATH}:${HOME}/.local/bin"

echo ' .. add default aliases'
alias ll="ls -alh"

if [ -f "$HOME/.aliases" ]; then
    echo " .. add local aliases"
    source $HOME/.aliases
fi

echo ' .. add shell functions'

# https://superuser.com/a/418299
echo ' .. bind keys'
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

echo " .. Initialising direnv"
eval "$(direnv hook zsh)"

echo " .. Initialising NVM"
# This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

echo " .. Initialising Starship prompt"
eval "$(starship init zsh)"

echo " .. Initialising iterm shell integration"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Moved from .zshenv to ensure it's the last thing that runs, otherwise
# the /etc/zprofile overtakes it.
echo " .. set PATH"
PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOMEBREW_PREFIX/bin:$PATH"
# fixes issue with pre-commit not finding packages
PATH="/Applications/Sublime Merge.app/Contents/SharedSupport/bin:$PATH"
PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
echo '<-- /Configuring shell [.zshrc]'
