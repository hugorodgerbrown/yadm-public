# Fig pre block. Keep at the top of this file.
export PATH="${PATH}:${HOME}/.local/bin"
eval "$(fig init zsh pre)"

#!/usr/bin/env zsh
echo '--> Configuring shell [.zshrc]'
echo ' .. set zsh options'
source $HOME/.zsh_options

echo ' .. add default aliases'
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew -v'
alias clear_pyc="find . -type f -name '*.pyc' | xargs rm -v"
alias ll="ls -al"
alias dc="docker compose"
alias mc="mutagen compose"
alias manage="docker compose run --rm django"
alias heroky="heroku run python manage.py"
alias git-signing-key="gpg --list-secret-keys --keyid-format=long | grep 'sec' | awk '{ print \$2 }' | awk -F '/' '{ print \$2 }'"

if [ -f "$HOME/.aliases" ]; then
    echo " .. add local aliases"
    source $HOME/.aliases
fi

echo ' .. add shell functions'
rebuild-container(){
    CONTAINER="${1:-django}"
    MODE="${2:-}"
    echo "Stopping $CONTAINER container" && docker compose stop $CONTAINER
    echo "Removing $CONTAINER container" && docker compose rm -sf $CONTAINER
    echo "Creating $CONTAINER container" && docker compose up $MODE $CONTAINER
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

echo " .. Initialising starship prompt"
eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Moved from .zshenv to ensure it's the last thing that runs, otherwise
# the /etc/zprofile overtakes it.
echo " .. set PATH"
PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
PATH="$PYENV_ROOT/bin:$PATH"
PATH="$HOME/.poetry/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOMEBREW_PREFIX/bin:$PATH"
echo '<-- /Configuring shell [.zshrc]'

# Fig post block. Keep at the bottom of this file.
eval "$(fig init zsh post)"

