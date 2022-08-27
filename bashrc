# prompt
RED='\033[0;31m'
GRAY='\033[1;30m'
YELLOW='\033[1;33m'
NC='\[\e[0m\]'
PS1="${RED}\u${YELLOW}@${GRAY}\h${NC}$ "

# history stuff
HISTCONTROL=ignoreboth
HISTSIZE=1000
shopt -s histappend

