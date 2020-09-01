#Author:mizoc <yaesuft729@gmail.com>
#https://github.com/mizoc/dotfiles
#license:MIT
#@ (#) My .zshrc
#
# --------------------------------------------------------------------------
#  ____  _____/ /_  __________   ____  / __/  ____ ___  (_)___  ____  _____
# /_  / / ___/ __ \/ ___/ ___/  / __ \/ /_   / __ `__ \/ /_  / / __ \/ ___/
#  / /_(__  ) / / / /  / /__   / /_/ / __/  / / / / / / / / /_/ /_/ / /__
# /___/____/_/ /_/_/   \___/   \____/_/    /_/ /_/ /_/_/ /___/\____/\___/
# --------------------------------------------------------------------------

fpath=(/usr/share/zsh/5.6.2/functions $fpath $HOME/.dotfiles/bin)

export LC_CTYPE="ja_JP.UTF-8"
export colors
export TERM="xterm-256color"
#export LANG=ja_JP.UTF-8
export LANG=C
export LC_ALL=C
export GOOS=linux
export GOARCH=amd64
export GOPATH=$HOME/go

#システムごとの設定ファイル(~/.zsh_ownrc)があれば読み込む
if test -f $HOME/.zsh_ownrc;then
	. $HOME/.zsh_ownrc
fi

# Ctrl + Dでログアウトされることを防ぐ
#setopt IGNOREEOF
#
#制御構文の短縮形を使用できるようにする
setopt short_loops

#ログアウト時のバックグラウンドジョブ継続
setopt nohup

# cdを使わずにディレクトリを移動できる
setopt auto_cd
#"cd -"の段階でTabを押すと、ディレクトリの履歴が見れる
setopt auto_pushd

# コマンドの打ち間違いを指摘してくれる
setopt correct

# '#' 以降をコメントとして扱う
setopt interactive_comments

#補完
autoload -Uz compinit
compinit -C #セキュリティチェックをしない => fast

autoload -Uz add-zsh-hook
autoload -Uz terminfo
autoload -Uz is-at-least

#補完後に十字キーで選択
zstyle ':completion:*:default' menu select=2
# 大文字も補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#色
autoload -Uz colors
colors
# tab補完中も色つける
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#lessに色付ける
export LESS='-R'
test -f /usr/bin/src-hilite-lesspipe.sh && export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s' #GNU source-highlightのインストール必須
#manにも色付ける
export MANPAGER='less -R'
man() {
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

#Setting of History
#他のターミナルとの履歴の共有
setopt share_history
# 重複は表示しない
setopt histignorealldups
# 半角スペースから始まるコマンドを履歴に入れない
setopt hist_ignore_space
#シェルの終了を待たずにコマンド履歴を保存
setopt inc_append_history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

#editor
export EDITOR=vim

#fzfがあれば実行
test -f ~/.fzf.zsh && source ~/.fzf.zsh
#fzfのオプション
export FZF_DEFAULT_OPTS="--ansi"

setopt no_tify
setopt extended_glob

# どこからでも参照できるディレクトリパス ~/bin等
cdpath=()

#パス通す
export PATH="$PATH:/sbin"
export PATH=$PATH:$HOME/bin/bin/
# export PATH=$PATH:$HOME/.dotfiles/bin/

# cdしたあとで、自動的に tree する(treeが泣ければls)
if type "colorls" >/dev/null 2>&1;then
	function chpwd(){
		if test `ls $(pwd) -R| wc -w` -gt 10 ;then
			tree --charset=C -L 1
		else
			colorls --tree
		fi}
elif type "tree" >/dev/null 2>&1;then
	function chpwd() { tree --charset=C -L 1; }
else
	function chpwd() { pwd;ls|sed -e 's/^/|-- /g'; }
fi

#vim mode
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
#deleteを使えるように
bindkey "^[[3~" delete-char #これをコメントアウトすると、deleteで大文字になってしまう

#Setting of pushd
setopt auto_pushd #自動でpushd実行
setopt pushd_ignore_dups #重複削除

#Setting of alias
alias vz="vim ~/.zshrc"
alias vzo="vim ~/.zsh_ownrc"
alias vv="vim ~/.vimrc"
alias vt="vim ~/.tmux.conf"
alias sz="source ~/.zshrc"

alias svim="vim -u ~/.simple_vimrc"

#サブディレクトリを含む容量
alias lsc='du -sh' #ls capacity
alias du='du -h' #単位をわかりやすく

#ls系
if type "colorls" >/dev/null 2>&1;then
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
#alias lst="ls -lhtr --color=auto"

# clear系
alias clear2="echo -e '\026\033c'" #バイナリファイルcatしたときの文字化け修正
alias clearcookie="rm -rf ~/.w3m/cookie && touch ~/.w3m/cookie "
alias clearhistory="rm -rf ~/.w3m/history && touch ~/.w3m/history "
alias clearw3m="clearcookie && clearhistory" #上2つの統合版
alias cleartrash="rm -rf ~/.local/share/Trash/files/*" #ゴミ箱カラ
alias clearconky="kill `pgrep -f 'conky -b -c'`"

# コピペの設定
which xsel >/dev/null 2>&1 && alias -g pbcopy="xsel --clipboard --input"; alias -g pbpaste="xsel --clipboard --output"

#Ctrl-rでいけるけどね
# %h history番号 -->でクリップボードに対応するコマンドをコピー -->Ctrl+Shift+vで貼り付けられる
function h(){
	history $1 | sed -n 1P|awk '{$1=""; print}' | tr -d "\n"| sed -e 's/^[ ]*//g' | pbcopy #trで改行捨て,sedで行頭の空白削除
}

#fzfがあれば実行
test -f ~/.fzf.zsh && source ~/.fzf.zsh && {alias -g his="history 0|tac|fzf --ansi --multi --reverse"; alias gl="git log --color|fzf --ansi --select-1 --reverse --multi"} || alias his="history 0"

#z.shがあれば実行
test -f ~/src/z/z.sh && . ~/src/z/z.sh

#git系
if type "colorls" >/dev/null 2>&1;then
	alias gs="colorls --gs -A"
	alias gst="colorls --gs -tA"
else
alias gs="git status"
fi
alias ga="git add ."
alias gp="git push"

alias -g mkdir="mkdir -p"

type "pacman" >/dev/null || alias pacman="myman"

#sl
alias dir="sl2" #sl2はslのnewバージョン/usr/local/bin/sl2にリンク貼ってる

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

#サフィックスのエイリアス設定
alias -s py=python3

#grep
alias -g grep='grep --color=always'

#Gitのステータス表示
function prompt-git-current-branch(){
	local branch_name st branch_status

	if [ ! -e ".git" ]; then
		return
	fi
	branch_name=`git branch|grep "*"|awk '{$1="";print}'|sed -e 's/^[ ]*//g'`
	st=`git status 2> /dev/null`
	k=" "

	if [[ -n `echo "$st" | grep "^nothing to"` ]];then
		branch_status="%F{blue}"
		k="%F{blue}"
	fi

	if [[ -n `echo "$st" | grep "^Untracked files"` ]];then
		branch_status="%F{cyan}"
		k+="%F{cyan}?%F{reset_color}"
	fi

	if [[ -n `echo "$st"|grep "^Changes not staged for commit"` ]];then
	  branch_status="%F{red}"
	  k+="%F{red}+%F{reset_color}"
	fi

	if [[ -n `echo "$st"|grep "^Changes to be committed"` ]];then
	  branch_status="%F{yellow}"
	  k+="%F{yellow}!%F{reset_color}"
	fi

	if [[ -n `echo "$st"|grep "^rebase in progress"` ]];then
		echo "%F{red}!(no branch)"
		return
	fi

	echo "${k}%F${branch_status}[$branch_name]%F{reset_color}"
}

function prompt-ssh(){
	[[ -n "${REMOTEHoST}${SSH_CONNECTION}" ]] && echo "%F{blue}[SSH]%F{reset_color}"
}

#コマンドプロンプトの設定
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color} %~
%# "

#コマンド実行前に呼ばれる関数
precmd(){
	RPROMPT="`prompt-ssh``prompt-git-current-branch`"
}

#入力された文字列を赤色にして返す(パイプ対応)
function reds(){
	case $1 in
		--help|-h)
			printf "\033[31m\033[1m%s\033[m\n"  "This is a program that echo red colored strings."
			echo ""
			echo '[Usage]'
			printf "\033[31m%s\033[m\n"  "\$reds [-h|--help] string  OR  \$reds [-h|--help] \"two strings\"  OR  \$cat filename|reds"
			;;

		*)
			if [ -p /dev/stdin ]; then
				if [ -n "`echo $@`" ]; then
					__str=`cat -`

				else
					#__str=$@
					__str=`cat /dev/stdin`
				fi
			else
				__str=$@
			fi

			printf "\033[31m%s\033[m\n" "${__str}"
			;;
	esac
}


function dot(){
	case "$1" in
		'')
			cd ~/.dotfiles;;
		'install')
			cd ~/.dotfiles
			./install.sh;;
		'uninstall')
			cd ~/.dotfiles
			./uninstall.sh;;
		'version'|'ver')
			cat ~/.dotfiles/version.txt;;
	esac
}


#spin [str]
function spin(){
	chars=('/' '-' '\' '|')
	while :;do
		for i in "$chars[@]";do
			echo -ne $1 "`reds $i`\r"
			sleep 0.1
		done
	done
}

#dots [str]
function dots(){
	echo -n $1
	while :;do
		echo -ne "."
		sleep 0.2
	done
}

#change volume
function volume(){
	amixer -c0 sset Headphone $1%,$1% unmute
	amixer -c0 sset Speaker $1%,$1% unmute
	amixer -c0 sset Master $1%,$1% unmute
}

#calculate
function calc(){
	echo "$*" | bc -l
}

#compile c program && excute
function co(){
	gcc "$1" && {shift
	./a.out $@
	}
}

#compile c++ program && excute
function cpo(){
	g++ $1 && {shift
	./a.out $@
	}
}

#enter template of C++ program to $1 file.
function cppt(){
	local template=`cat <<EOF
#include<iostream>
#include<string>
#include<cstdio>
using namespace std;

int main(){

	return 0;
}
EOF
`
	if test -f "$1";then
		echo "File $1 is already exist" 1>&2
		echo "[Usage] \$$0 NEW-CPP-FILEPATH" 1>&2
	else
		echo $template >"$1"
	fi

}

#disable r(remove) option
function crontab(){
	test "$1" = "-r" -o "$1" = "--remove" && return 1 || crontab "$@"
}

#youtube download
function ydl(){
if type "youtube-dl" >/dev/null 2>&1;then
	youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0 "$0"
else
	ydl $@
fi
}

# calは元号入力に対応させた関数(第一引数は年号)
function cal(){
	year=`echo $1|awk '{print substr($0,2)}'`
	other=`echo $@|awk '{$1=""; print}'`
	case `echo $1 |awk '{print substr($0,1,1)}'` in
		H|h)
			seireki=$(($year + 1988))
			k="H$year = $seireki"
			;;
		S|s)
			seireki=$(($year + 1925))
			k="S$year = $seireki"
			;;
		R|'r')
			seireki=$(($year + 2018))
			k="R$year = $seireki"
			;;
		*)
			seireki=$1
			k=""
	esac

	reds $k
	/usr/bin/cal $seireki $other
}

function what(){
	if test -f "$1" ;then
		head "$1" | /bin/grep -m 1 '#@' | sed 's/.*)//g'
	else
		exit 1
	fi
}

# 引数に検索したい文字列を入れる(空白を含む場合は""でかこう) --> w3mでgoogle検索
function whats(){
	case $1 in
		--help|-h)
			echo Usage
			echo "whats [keyworld]  -->google search"
			;;
		*)
			if [ -p /dev/stdin ]; then
				if ["`echo $@`" == ""]; then
					__str=`cat -`

				else
					__str=$@
				fi
			else
				__str=$@
			fi

			w3m "https://www.google.com/search?q=${__str}"
			;;
	esac
}

#自作関数等の補完設定
_color(){
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

#ディストリビューション名表示
if test -f /etc/slackware-version;then
	distro=`cat /etc/slackware-version`
elif test -f /etc/redhat-release;then
	distro=`cat /etc/redhat-release`
elif test -f /etc/fedora-release;then
	distro=`cat /etc/fedora-release`
elif test -f /etc/SuSE-release;then
	distro=`cat /etc/SuSE-release`
elif test -f /etc/lsb-release;then
	distro=`cat /etc/lsb-release|/bin/grep 'DISTRIB_DESCRIPTION'|sed 's/DISTRIB_DESCRIPTION=//'|tr -d ' '|tr -d '"'`
elif test -f /etc/debian_version;then
	distro=Debian`cat /etc/debian_version`
else
	distro=`uname`
fi

printf "\033[31m\033[1m\033[4m%s\033[m\n" "`zsh --version|awk '{$3=""; print}'|tr -d " "`@`echo $distro|tr -d " "`"

#setting of zplug
#installtion
if test -f ~/.zplug/init.zsh;then
	:
else
	export ZPLUG_HOME=~/.zplug
	git clone https://github.com/zplug/zplug $ZPLUG_HOME

fi

#excute
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

#移動
zplug "b4b4r07/enhancd", use:enhancd.sh, lazy:true
#ハイライト
zplug "zsh-users/zsh-syntax-highlighting", defer:2
#タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
#peco これをコメントアウトするとなぜかzplugが壊れる
# zplug "peco/peco", as:command, from:gh-r, use:"*amd64"
#fzf
zplug "junegunn/fzf-bin", lazy:true
zplug "junegunn/fzf", lazy:true

zplug load

# 起動速度の計測があればする
which zprof >/dev/null 2>&1 || return 0 && zprof|less
