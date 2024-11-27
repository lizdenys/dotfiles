alias l='ls'
alias ll='ls -alF --full-time'
alias la='ls -AlF'
alias dir='ls'
alias sl='ls'
alias lsa='ls'
alias lsd='ls'
alias lll='ll'
alias llll='ll'
alias lllll='ll'
alias llllll='ll'
alias kk='ll'
alias lless='l | less'

alias sls='screen -list'

alias c='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias xs='cd'
alias vf='cd'
alias scd='cd'

alias temacs='emacs'
alias e='emacs'
alias eamcs='emacs'
alias meacs='emacs'
alias emasc='emacs'

alias moer='more'
alias moew='more'
alias lses='less'

alias haed='head'
alias heda='head'
alias first='head -1'
alias last='tail -1'

alias count='sort | uniq -c'

alias h='history'

alias j='jobs -l'
alias g='egrep -i'
alias p='ps aux'
alias pg='p|g'

alias clear='clear;clear'
alias c=clear

alias t='tail'
alias tf='tail -F'

alias which='type -all'

alias dexit='disown; exit'

alias clock='date "+%H:%M:%S"'

alias f='finger'

alias playmusic='mplayer *.mp3 *.m4a'
alias playall='playmusic'
alias mplay='mplayer'

# allow for a local component
if [ -f ~/.bash_aliases.mine ]; then
    source ~/.bash_aliases.mine
fi
