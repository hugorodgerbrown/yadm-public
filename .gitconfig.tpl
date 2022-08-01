[user]
  name =
  email =
  signingkey =
[commit]
  gpgsign = true
[pull]
  rebase = false
[push]
  autoSetupRemote = true
[credential]
  helper = /usr/local/share/gcm-core/git-credential-manager-core
[alias]
  sync = "!git fetch origin $1:$1"
  purge = "!git ls-files --others --exclude-standard | xargs rm -v"
  signing-key = "!gpg --list-secret-keys --keyid-format=long | grep 'sec' | awk '{ print $2 }' | awk -F '/' '{ print $2 }'"
  release = "!git tag -a \"$1\" -m 'Release version \"$1\"' #"
  pretty = "!git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
