#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Standard Prompt
#PS1='[\u@\h \w]\$ '

# bash options
shopt -s autocd         # Auto cd when entering just path
shopt -s cdspell        # autocorrects cd misspellings
shopt -s histappend     # do not overwrite history
shopt -s dotglob        # include dotfiles in pathname expansion
shopt -s expand_aliases # expand aliases

# set history variables
unset HISTFILESIZE
HISTSIZE="10000"
HISTCONTROL=ignoreboth:erasedups

# share history across all terminals
PROMPT_COMMAND="history -a; history -c; history -r"
export HISTSIZE PROMPT_COMMAND

# Git-prompt
source ~/dotfiles/bash/.bash_prompt

# fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# command not found
source /usr/share/doc/pkgfile/command-not-found.bash

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion

# dircolors
# eval $(dircolors -b ~/.dir_colors)

# visual bell
set bell-style visible

# aliase
alias ls='ls -hN --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -a'
alias lx="ls -xb"           # sort by extension
alias lk="ls -lSr"          # sort by size, biggest last
alias lc="ls -ltcr"         # sort by and show change time, most recent last
alias lu="ls -ltur"         # sort by and show access time, most recent last
alias lt="ls -ltr"          # sort by date, most recent last
alias lm="ls -al |more"     # pipe through 'more'
alias lr="ls -lR"           # recursive ls
alias lsr="tree -Csu"       # nice alternative to 'recursive ls'
export GREP_COLOR="33"
alias grep='grep --color=always'
alias dir='dir --color=auto'

# General
alias sudo="sudo "
alias vim="nvim"
alias yt="youtube-viewer"
#alias vimdiff="nvim -d"


# start mutt in ~/downloads/attachments
alias mutt='cd ~/downloads/ && mutt'

# hrhr
alias please='sudo $(history -p \!\!)'

# preventing nested ranger instances
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

# tmux connections
shux() { ssh "$1" -t LANG=en_US.utf8 tmux a -d ; }

# images
sx() { sxiv -tq "$@" 2>/dev/null ;}

# Extract Files
extract() {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "\`$1': unrecognized file compression" ;;
      esac
  else
      echo "\`$1' is not a valid file"
  fi
}

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

[ -f "$HOME/.config/shortcuts/shortcutrc" ] && source "$HOME/.config/shortcuts/shortcutrc"
