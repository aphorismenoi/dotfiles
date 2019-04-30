#
# ~/.profile
#

# source .bashrc
if [ -n "$BASH" ] && [ -r ~/.bashrc ]; then
  . ~/.bashrc
fi

# setup default dirs
[[ "$XDG_CACHE_HOME" ]] || export XDG_CACHE_HOME="$HOME/.cache"
[[ "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME="$HOME/.config"
[[ "$XDG_DATA_HOME" ]] || export XDG_DATA_HOME="$HOME/.local/share"

# some exports
export PATH=$PATH:$HOME/.scripts
export SHELL=/bin/bash
#export PAGER=less
export EDITOR="nvim"
export FCEDIT="nvim"
export VISUAL="$EDITOR"
export GPG_TTY=$(tty)
export GPGKEY="BF0A2EB2"
export GPG_AGENT_INFO=$HOME/.gnupg/S.gpg-agent
export BROWSER=qutebrowser
export BROWSERCLI=w3m
export READER=zathura
export IMAGEVIEWER=feh
export VIDEOPLAYER=mpv
export HISTCONTROL=ignoredups
export SYSTEMD_PAGER="less -R"
export PASSWORD_STORE_DIR="$HOME/.password-store/"

# coloured man pages
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;33m'

# start keychain
if [[ -z $(pidof ssh-agent) && -z $(pidof gpg-agent) ]]; then
  eval $(/usr/bin/keychain --eval -Q -q --nogui --agents "ssh,gpg" id_rsa BF0A2EB2)
  [[ -z $HOSTNAME ]] && HOSTNAME=$(uname -n)
  [[ -f $HOME/.keychain/${HOSTNAME}-sh ]] && source $HOME/.keychain/${HOSTNAME}-sh
  [[ -f $HOME/.keychain/${HOSTNAME}-sh-gpg ]] && source $HOME/.keychain/${HOSTNAME}-sh-gpg
fi

# autostart X at login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
