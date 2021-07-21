#!/bin/zsh
echo '--> Configuring shell'
echo '... setting zsh options'
setopt HIST_IGNORE_ALL_DUPS         # ignore duplication command history list
setopt HIST_VERIFY                  # expand history onto the current line instead of executing it
setopt HIST_EXPIRE_DUPS_FIRST       # remove oldest duplicate commands from the history first
setopt HIST_IGNORE_SPACE            # don't save commands beginning with spaces to history
setopt HIST_FIND_NO_DUPS            # skip through duplicates when navigating history

# https://superuser.com/a/418299
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

echo '... setting up default aliases'
alias clear_pyc="find . -type f -name '*.pyc' -exec rm -f {} \;"
alias ll="ls -al"
alias dc="docker compose"
alias mc="mutagen compose"
alias manage="docker compose run --rm django"
alias heroky="heroku run python manage.py"

rebuild-container(){
    CONTAINER="${1:-django}"
    MODE="${2:-}"
    echo "Stopping $CONTAINER container" && mutagen compose stop $CONTAINER
    echo "Removing $CONTAINER container" && mutagen compose rm -sf $CONTAINER
    echo "Creating $CONTAINER container" && mutagen compose up $MODE $CONTAINER
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

if [ -f "$HOME/.aliases" ]; then
    echo "... setting up additional aliases"
    source $HOME/.aliases
fi

echo "--> Initialising direnv"
eval "$(direnv hook zsh)"

echo "--> Initialising pyenv"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

echo "--> Initialising NVM"
# This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

echo "--> Configuring prompt"
eval "$(starship init zsh)"
