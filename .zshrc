#!/usr/bin/env zsh
export PATH="${PATH}:${HOME}/.local/bin"

echo '--> Configuring shell [.zshrc]'
echo ' .. set zsh options'
source $HOME/.zsh_options

echo ' .. add default aliases'
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew -v'
alias clear_pyc="find . -type f -name '*.pyc' | xargs rm -v"
alias ll="ls -al"
alias dc="docker compose"
alias heroky="heroku run python manage.py"

if [ -f "$HOME/.aliases" ]; then
    echo " .. add local aliases"
    source $HOME/.aliases
fi

echo ' .. add shell functions'

# resets the global git config and injects signing key
reset-git-config(){
    echo "Resetting global git config username, email and signing-key"
    vared -p "What is your name? " -c GIT_USER_NAME
    vared -p "What is your email? " -c GIT_USER_EMAIL
    cp $HOME/.gitconfig.tpl $HOME/.gitconfig
    git config --global user.name $GIT_USER_NAME
    git config --global user.email $GIT_USER_EMAIL
    git config --global user.signingkey $(git signing-key)
}

# outputs the number of PRs merged and line diff between two dates
git-counter(){
    echo "Fetching git stats between $1 and $2"
    date=$1
    count=$(git log --oneline --no-merges --after=$1 --before=$2 | wc -l)
    start=$(git log --after=$1 --before=$2 --format="%h" | tail -n 1)
    end=$(git log --after=$1 --before=$2 --format="%h" | head -n 1)
    stats=$(git diff $start..$end --shortstat)
    echo "$count PRs merged; $stats"
}

# https://superuser.com/a/418299
echo ' .. bind keys'
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

echo " .. Initialising direnv"
eval "$(direnv hook zsh)"

echo " .. Initialising pyenv"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

echo " .. Initialising NVM"
# This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

echo " .. Initialising Starship prompt"
eval "$(starship init zsh)"

echo " .. Initialising 1Password shell integration"
eval "$(op completion zsh)"; compdef _op op

echo " .. Initialising iterm shell integration"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Moved from .zshenv to ensure it's the last thing that runs, otherwise
# the /etc/zprofile overtakes it.
echo " .. set PATH"
PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
PATH="$PYENV_ROOT/bin:$PATH"
PATH="$HOME/.poetry/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOMEBREW_PREFIX/bin:$PATH"
# fixes issue with pre-commit not finding packages
PATH="/Applications/Sublime Merge.app/Contents/SharedSupport/bin:$PATH"
echo '<-- /Configuring shell [.zshrc]'
