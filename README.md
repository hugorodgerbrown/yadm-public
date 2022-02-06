# yadm-public
Public version of my local setup (no work-related aliases)

## Order of script execution

From https://www.erikstockmeier.com/blog/12-5-2019-shell-startup-scripts

Source |	Interactive login	| Interactive non-login	| Script
:-- | :---: | :---: | :---:
`/etc/zshenv`	|A	|A	|A
`~/.zshenv`	|B	|B	|B
`/etc/zprofile`|	C|		|
`~/.zprofile`	|D	|	|
`/etc/zshrc`	|E	|C	|
`~/.zshrc`	|F	|D	|
`/etc/zlogin`	|G		||
`~/.zlogin`	|H		||
logout only:			
`~/.zlogout`	|I		||
`/etc/zlogout`	|J	||
