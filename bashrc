# ~/.bashrc: executed by bash(1) for non-login shells.

# if we're not running interactively, don't do anything.
[ -z "$PS1" ] && return

# privacy
umask 077

# more history
export HISTCONTROL=ignoredups:ignorespace:erasedups
export HISTSIZE=5000
export HISTFILESIZE=5000
shopt -s histappend

# cyclic tab completion
bind '"\t":menu-complete'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -F'
else
    # for reference, see http://norbauer.com/notebooks/code/notes/ls-colors-and-terminal-app
    export CLICOLOR="yes"
    export LSCOLORS="DxGxFxdxCxDxDxhbadExEx";
    alias ls='ls -F'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# general convenience
export PATH=$PATH:~/bin:
export EDITOR="emacs"
alias emacs='emacs -nw'
export LESS="--ignore-case --line-numbers"
export GREP_OPTIONS="--color=auto --exclude-dir=.svn --exclude-dir=.bzr --exclude-dir=.git --exclude-dir=.pc"
export MALLOC_OPTIONS="J" # for freebsd

# search through source for various languages
srcfind () {
  grep -n -r --include=*.{c,cc,h,S,py,R,r} "$@" .
}

# horrible person way to half fix an unwanted mv!
unmv () {
  mv "$2" "$1"
}

# diff in opposite order
revdiff () {
  diff "$2" "$1"
}

# dynamic titles for screen
case $TERM in
  screen*) export PROMPT_COMMAND='echo -n -e "\033k\033\\"'
esac

# keep typos & convenience aliasing separate for, uh, cleanliness?
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# allow for a local component
if [ -f ~/.bashrc.mine ]; then
   source ~/.bashrc.mine
fi
