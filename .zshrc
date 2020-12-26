#Author:mizoc <yaesuft729@gmail.com>
#Repository:https://github.com/mizoc/dotfiles
#License:MIT
#@ (#) My .zshrc
#
# --------------------------------------------------------------------------
#  ____  _____/ /_  __________   ____  / __/  ____ ___  (_)___  ____  _____
# /_  / / ___/ __ \/ ___/ ___/  / __ \/ /_   / __ `__ \/ /_  / / __ \/ ___/
#  / /_(__  ) / / / /  / /__   / /_/ / __/  / / / / / / / / /_/ /_/ / /__
# /___/____/_/ /_/_/   \___/   \____/_/    /_/ /_/ /_/_/ /___/\____/\___/
# --------------------------------------------------------------------------

fpath=(/usr/share/zsh/functions $fpath)

export LC_CTYPE="ja_JP.UTF-8"
export colors
export TERM="xterm-256color"
#export LANG=ja_JP.UTF-8
export LANG=C
export LC_ALL=C

export GOOS=linux
export GOARCH=amd64
export GOPATH=$HOME/go

# path
export PATH="$PATH:/sbin"
export PATH=$PATH:$HOME/bin/bin/:"/home/taichi/.local/bin:/snap/bin"
export PATH="$HOME/.cargo/bin:$PATH"


# システムごとの設定ファイル(~/.zsh_ownrc)があれば読み込む
if test -f $HOME/.zsh_ownrc; then
  . $HOME/.zsh_ownrc
fi

# setopts
#setopt IGNOREEOF #prevent logout by Ctrl-d
setopt nonomatch #zsh: no matches found 対策
setopt short_loops #control syntax abbreviations available
setopt nohup #continue to run background jobs when logout
setopt auto_cd #cd without 'cd'
setopt auto_pushd #display history of cd by 'cd -<tab>'
setopt correct #point out typos
setopt interactive_comments # treat after '#' as a comment
setopt auto_pushd # run pushed automatically
setopt pushd_ignore_dups #rm dups


# complement
autoload -Uz compinit
compinit -C # do not do security check

autoload -Uz add-zsh-hook
autoload -Uz terminfo
autoload -Uz is-at-least

zstyle ':completion:*:default' menu select=2 #select completion by arrow key
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' #complement uppercase letters

# color settings
autoload -Uz colors
colors
zstyle ':completion:*' verbose yes #coloring while completion
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-colors di=4 ex=33 '=*.cpp=35' '=*.py=34' '=*.rb=31' '=*.sh=32'

#coloring less
export LESS='-R'
test -f /usr/share/source-highlight/src-hilite-lesspipe.sh && export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s' #GNU source-highlightのインストール必須
#coloring man
export MANPAGER='less -R'
man()
{
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;33m") \
    LESS_TERMCAP_md=$(printf "\e[1;36m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}
test -f ~/.dir_colors && eval `dircolors -b ~/.dir_colors`

#Setting of History
setopt share_history #share history with other terminals
setopt histignorealldups #do not show dups
setopt hist_ignore_space #commands which start with space will not be logged
setopt inc_append_history #save history without waiting it finishes
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# editor
export EDITOR=vim

# fzf
test -f ~/.fzf.zsh && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--ansi" # option of fzf
test -f ~/.fzf.zsh && source ~/.fzf.zsh && alias -g his="history 0|tac|fzf --ansi --multi --reverse" || alias his="history 0"
# alias gl="git log --color|fzf --ansi --select-1 --reverse --multi"} || alias his="history 0"

setopt no_tify
setopt extended_glob

# dir path which can be accessed from anywhere
cdpath=()

# run tree[/ls] after cd
if type "colorls" >/dev/null 2>&1; then
  function chpwd()
  {
    if test $(ls $(pwd) -R | wc -w) -gt 10 -o "/home/taichi" = "$(pwd)"; then
        :
      # tree --charset=C -L 1
    else
      colorls --tree
    fi
  }
elif type "tree" >/dev/null 2>&1; then
  function chpwd()
  {
    if test $(ls $(pwd) -R | wc -w) -gt 10 -o "/home/taichi" = "$(pwd)"; then
        :
    else
        tree --charset=C -L 1
    fi
  }
else
  function chpwd()
  {
    pwd
    ls | sed -e 's/^/|-- /g'
  }
fi

# github cli completion
type "gh" >/dev/null 2>&1 && eval "$(gh completion -s zsh)"

# keybind( vim mode)
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey "^[[3~" delete-char #for delete key

# Ctrl-r for history search
if type "fzf" >/dev/null 2>&1; then
  function select-history()
  {
    BUFFER=$(history -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > " | awk '{$1="";print }' | sed 's/^ //g')
    CURSOR=$#BUFFER
  }
  zle -N select-history
  bindkey '^r' select-history
else
  bindkey '^R' history-incremental-search-backward
fi

# Ctrl-space for accept autosuggestions
zle -N autosuggest-accept
bindkey '^ ' autosuggest-accept

# select menu by hjkl
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# use Ctrl-hjkl instead of allow key for selecting history
bindkey '^k' up-history
bindkey '^j' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# alias
alias vz="vim ~/.dotfiles/.zshrc"
alias vzo="vim ~/.zsh_ownrc"
alias vv="vim ~/.dotfiles/.vimrc"
alias vt="vim ~/.dotfiles/.tmux.conf"
alias sz="source ~/.zshrc"
alias v3="vim ~/.dotfiles/i3-config"
alias svim="vim -u ~/.simple_vimrc"

# simplenote
alias note='vim -c "SimplenoteList"'
alias todo='vim -c Todo -c on'
alias new='vim -c "SimplenoteNew"'

# show capacity
alias lsc='du -sh' #ls capacity
alias du='du -h'   #use easy-to-understand unit

# shell script formatter
if test -f $HOME/go/bin/shfmt;then
  alias shfmt='$HOME/go/bin/shfmt -i 2 -ci -bn -fn -s' # add 'w' option to overwrite
else
  go get -u github.com/mvdan/sh/cmd/shfmt
fi

# pip3
which pip3 >/dev/null 2>&1 && alias pip='pip3'

#ls
if type "colorls" >/dev/null 2>&1; then
  alias -g ls="ls -FX --color=auto --color=always"
  alias -g cls="colorls --sd"
  alias -g l="colorls --sd -lA --report"
  alias -g la="colorls --sd -al --report"
  alias -g ll="colorls --sd -Al --report"
  alias -g ld="colorls -d"
  alias -g lf="colorls -f"
  alias -g lsr="ls -FXR --color=auto"
else
  alias -g ls="ls -FX --color=auto --color=always"
  alias -g lsr="ls -FXR --color=auto --color=always"
  alias -g l="ls -FXSlth --color=auto --color=always"
  alias -g la="ls -FSXlha --color=auto --color=always"
  alias -g ll="ls -FSXlh --color=auto --color=always"
fi
alias k="k -h"

# clear
alias clear2="echo -e '\026\033c'" # clear when cat binary file
alias clearw3m="rm -rf ~/.w3m/cookie && touch ~/.w3m/cookie ;rm -rf ~/.w3m/history && touch ~/.w3m/history " # clear w3m logs
alias cleartrash="rm -rf ~/.local/share/Trash/files/*" # clear trash
alias clearconky="kill $(pgrep -f 'conky -b -c')"

# colordiff
if [[ -x $(which colordiff) ]]; then
  alias diff='colordiff'
fi

# copy & paste
which xsel >/dev/null 2>&1 && alias -g pbcopy="xsel --clipboard --input"
alias -g pbpaste="xsel --clipboard --output"

# copy history to clipboard $h history-number
function h()
{
  history $1 | sed -n 1P | awk '{$1=""; print}' | tr -d "\n" | sed -e 's/^[ ]*//g' | pbcopy #trで改行捨て,sedで行頭の空白削除
}

#git系
alias gs="git status -sb"
alias ga="git add ."
alias gp="git push"
alias gc="git commit"
alias gd="git diff"
alias gl='git log --pretty="medium-reverse" --graph --stat'

alias -g mkdir="mkdir -p"

# game
type "pacman" >/dev/null || alias pacman="myman"

#cd
alias -g ..="../"
alias -g cd1="../"
alias -g ...="../../"
alias -g cd2="../../"
alias -g ....="../../../"
alias -g cd3="../../../"

#awk
alias -g a1="awk '{print \$1}'"
alias -g a2="awk '{print \$2}'"
alias -g a3="awk '{print \$3}'"
alias -g a4="awk '{print \$4}'"
alias -g a5="awk '{print \$5}'"
alias -g a6="awk '{print \$6}'"
alias -g a7="awk '{print \$7}'"
alias -g a8="awk '{print \$8}'"
alias -g a9="awk '{print \$9}'"
alias -g a10="awk '{print \$10}'"

# alias setting by suffix
alias -s py=python3
which mpv >/dev/null 2>&1 && alias -s mp3=mpv

# grep
alias -g grep='grep --color=always'

# show git status for prompt
function prompt-git-current-branch()
{
  local branch_name st branch_status

  if [ ! -e ".git" ]; then
    return
  fi
  branch_name=$(git branch | grep "*" | awk '{$1="";print}' | sed -e 's/^[ ]*//g')
  st=$(git status 2>/dev/null)
  k=" "

  if [[ -n $(echo "$st" | grep "^nothing to") ]]; then
    branch_status="%F{blue}"
    k="%F{blue}"
  fi

  if [[ -n $(echo "$st" | grep "^Your branch is ahead of ") ]]; then #push
    branch_status="%F{blue}"
    k+="%F{yellow}^`echo "$st" | /bin/grep "^Your branch is ahead of "|sed -e 's/.*by //g' -e 's/ commit.*//g'`%F{reset_color}"
  fi

  if [[ -n $(echo "$st" | grep "^Untracked files") ]]; then
    branch_status="%F{cyan}"
    k+="%F{cyan}?%F{reset_color}"
  fi

  if [[ -n $(echo "$st" | grep "^Changes not staged for commit") ]]; then
    branch_status="%F{red}"
    k+="%F{red}+%F{reset_color}"
  fi

  if [[ -n $(echo "$st" | grep "^Changes to be committed") ]]; then
    branch_status="%F{yellow}"
    k+="%F{yellow}!%F{reset_color}"
  fi

  if [[ -n $(echo "$st" | grep "^rebase in progress") ]]; then #conflict
    echo "%F{red}!(no branch)"
    return
  fi

  echo "${k}%F${branch_status}[$branch_name]%F{reset_color}"
}

function prompt-ssh()
{
  [[ -n "${REMOTEHoST}${SSH_CONNECTION}" ]] && echo "%F{blue}[SSH]%F{reset}"
}

# prompt
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color} %~
%# "

# function which run when run some command
precmd()
{
  RPROMPT="$(prompt-ssh)$(prompt-git-current-branch)"
}


#Return string after coloring
#Usage
#    $color cyan say hello
#    $echo hello world|color blue
function color() {
  case $1 in
    black)    shift; echo -e "\033[1;30m$*\033[m";;
    red)      shift; echo -e "\033[1;31m$*\033[m";;
    green)    shift; echo -e "\033[1;32m$*\033[m";;
    yellow)   shift; echo -e "\033[1;33m$*\033[m";;
    blue)     shift; echo -e "\033[1;34m$*\033[m";;
    magenta)  shift; echo -e "\033[1;35m$*\033[m";;
    cyan)     shift; echo -e "\033[1;36m$*\033[m";;
    white)    shift; echo -e "\033[1;37m$*\033[m";;
    *) echo -e "\033[0m$*\033[m";;
  esac
}
# completion
_color()
{
  _values \
    'colors' \
    'black' \
    'red' \
    'green' \
    'yellow' \
    'blue' \
    'magenta' \
    'cyan' \
    'white'
}
compdef _color color


function dot()
{
  case "$1" in
    '')
      test "$HOME/.dotfiles" = "`pwd`" || PREVIOUS_DIR=`pwd`
      cd ~/.dotfiles
      ;;
    'install')
      test "$HOME/.dotfiles" = "`pwd`" || PREVIOUS_DIR=`pwd`
      cd ~/.dotfiles
      ./install.sh
      ;;
    'uninstall')
      test "$HOME/.dotfiles" = "`pwd`" || PREVIOUS_DIR=`pwd`
      cd ~/.dotfiles
      ./uninstall.sh
      ;;
    'check')
       ~/.dotfiles/check.sh
      ;;
    'update')
      test "$HOME/.dotfiles" = "`pwd`" || PREVIOUS_DIR=`pwd`
      cd ~/.dotfiles
      ./update.sh
      ;;
    'back')
      cd ${PREVIOUS_DIR:=$HOME}
      ;;
  esac
}
# completion
_dot()
{
  _values \
    'mode' \
    'back[back to the dir where you were]' \
    'install[install dotfiles]' \
    'uninstall[uninstall dotfiles]' \
    'check[check if my favorite pkgs are installed]'
}
compdef _dot dot


#$newsh new_shell_script ==> {touch new_shell_script.sh; chmod +x $_; vim $_}
function newsh()
{
  if test "$(echo "$1" | rev | cut -c 1-3)" = "hs."; then
    local FILENAME="$1"
  else
    local FILENAME="$1.sh"
  fi

  [ -z "$FILENAME" -o -f "$FILENAME" ] && return 1
  echo '#!/bin/bash\n' >"$FILENAME" && chmod +x "$FILENAME" && vim "$FILENAME"
}


#spin [str]
function spin()
{
  trap 'echo;return' 2
  local chars=('/' '-' '\' '|')
  while :; do
    for i in "$chars[@]"; do
      echo -ne $1 "$(color red $i)\r"
      sleep 0.1
    done
  done
}

#dots [str]
function dots()
{
  trap 'echo;return' 2
  echo -n $1
  while :; do
    echo -ne "."
    sleep 0.2
  done
}

#change volume
function volume()
{
  amixer -c0 sset Headphone $1%,$1% unmute
  amixer -c0 sset Speaker $1%,$1% unmute
  amixer -c0 sset Master $1%,$1% unmute
}

#calculate
function calc()
{
  echo "$*" | bc -l
}

#disable r(remove) option
function crontab()
{
  test "$1" = "-r" -o "$1" = "--remove" && return 1 || crontab "$@"
}

#youtube downloader
#Audio:  $ydl URL
#Video:  $ydl -v URL
function ydl()
{
  if type "youtube-dl" >/dev/null 2>&1; then
    if test "$1" = "-v";then
        shift
        youtube-dl -i --quiet --merge-output-format mp4 -f 'bestvideo+bestaudio[ext=m4a]' -o %(title)s.%(ext)s "$1"
    else
        youtube-dl -i --quiet --extract-audio --audio-format mp3 --audio-quality 0 -o %(title)s.%(ext)s "$1"
    fi
  else
    ydl $@
  fi
}

# calは元号入力に対応させた関数(第1引数は年号)
function cal()
{
  local YEAR=$(echo $1 | awk '{print substr($0,2)}')
  local OTHER=$(echo $@ | awk '{$1=""; print}')
  local SEIREKI K
  case $(echo $1 | awk '{print substr($0,1,1)}') in
    H | h)
      SEIREKI=$((YEAR + 1988))
      K="H$year = $SEIREKI"
      ;;
    S | s)
      SEIREKI=$((YEAR + 1925))
      K="S$year = $SEIREKI"
      ;;
    R | 'r')
      SEIREKI=$((YEAR + 2018))
      K="R$year = $SEIREKI"
      ;;
    *)
      SEIREKI=$1
      K=""
      ;;
  esac

  color red $K
  /usr/bin/cal $SEIREKI $OTHER
}

function what()
{
  if test -f "$1"; then
    head "$1" | /bin/grep -m 1 '#@' | sed 's/.*)//g'
  else
    return 1
  fi
}

# search $1 by w3m
function whats()
{
  case $1 in
    --help | -h)
      echo Usage
      echo "whats [keyworld]  -->google search"
      ;;
    *)
      local SEARCH_STR=
      if [ -p /dev/stdin ]; then
        if ["$(echo $@)" == ""]; then
          SEARCH_STR=$(cat -)

        else
          SEARCH_STR=$@
        fi
      else
        SEARCH_STR=$@
      fi

      if type 'w3m' >/dev/null 2>&1;then
        w3m "https://www.google.com/search?q=${SEARCH_STR}"
        return 0
      else
        echo 'w3m not found' >&2
        return 1
      fi
      ;;
  esac
}

#第1引数のコマンドが存在するかどうかを確認
#Check if command($1) is exist
#Exit status
# 0:exist, 1:not exist, 2:$1 is empty
function has(){
  test -z "$1" && return 2
  type "$1" >/dev/null 2>&1
  return $?
}

#Ask y/n by printing $1(default: "yes or no? [y/n]")
#Return
# 0:Yes, 1:No
function ask_ok()
{
  local QUESTION=${1:-"yes or no? [y/n] "}
  local ANS=
  while :;do
    echo -n "$QUESTION"
    read ANS
    case "$ans" in
      "y"|"Y"|"Yes"|"yes"|"YES")
        return 0;;
      "N"|"n"|"no"|"No"|"NO")
        return 1;;
      *)
        echo "type Y or N"
    esac
  done
}

# print distribution name
if test -f /etc/slackware-version; then
  distro=$(cat /etc/slackware-version)
elif test -f /etc/redhat-release; then
  distro=$(cat /etc/redhat-release)
elif test -f /etc/fedora-release; then
  distro=$(cat /etc/fedora-release)
elif test -f /etc/SuSE-release; then
  distro=$(cat /etc/SuSE-release)
elif test -f /etc/lsb-release; then
  distro=$(cat /etc/lsb-release | /bin/grep 'DISTRIB_DESCRIPTION' | sed 's/DISTRIB_DESCRIPTION=//' | tr -d ' ' | tr -d '"')
elif test -f /etc/debian_version; then
  distro=Debian$(cat /etc/debian_version)
else
  distro=$(uname)
fi

printf "\033[31m\033[1m\033[4m%s\033[m\n" "$(zsh --version | awk '{$3=""; print}' | tr -d " ")@$(echo $distro | tr -d " ")"

# Plugin (zinit)
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" \
    && print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" \
    || print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node

zinit load mollifier/cd-gitroot #cd
zinit load zsh-users/zsh-syntax-highlighting #highlight
# completion
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions
zinit load chrissicool/zsh-256color
# filter
zinit load peco/peco
zinit load junegunn/fzf-bin
zinit load junegunn/fzf
#emoji
zinit load b4b4r07/emoji-cli
#ls with git information
zinit load supercrabtree/k

# measurement of startup speed
which zprof >/dev/null 2>&1 || return 0 && zprof | less
