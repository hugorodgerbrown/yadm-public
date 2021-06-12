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

echo '... setting up aliases'
alias clear_pyc="find . -type f -name '*.pyc' -exec rm -f {} \;"
alias ll="ls -al"
alias dc="docker compose"
alias mc="mutagen compose"
alias manage="docker compose run --rm django"
alias heroky="heroku run python manage.py"

restart-django(){
    echo "Stopping django container" && mutagen compose stop django
    echo "Removing django container" && mutagen compose rm -sf django
    echo "Creating django container" && mutagen compose up $1 django
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
    echo "... setting up external aliases"
    source $HOME/.aliases
fi

echo "--> Initialising pyenv"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

echo "--> Initialising NVM"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "--> Configuring Starship prompt"
eval "$(starship init zsh)"
