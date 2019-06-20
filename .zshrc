#Author:mizoc <yaesuft729@gmail.com>
#https://github.com/mizoc/dotfiles
#license:MIT
#___  _____/ /_  __________
# /_  / / ___/ __ \/ ___/ ___/
#  / /_(__  ) / / / /  / /__
# /___/____/_/ /_/_/   \___/
# --------------------------------------------------

#これをしないとpowerlineが表示エラーになる
export LC_CTYPE="en_US.UTF-8"
#---------参考----------
# $echo -e '\u2190\u2191\u2192\u2193'
# 	これがエラーなく動く-->OK
# 	以下のようなエラーが出る --> $export LC_CTYPE="en_US.UTF-8"
# 		zsh: character not in range
export colors
export TERM="xterm-256color"

# 日本語にすると表示が日本語になって嫌なので、コメントアウト
#export LANG=ja_JP.UTF-8
export LANG=C

#システムごとの設定ファイル(~/.zsh_ownrc)があれば読み込む
if test -f $HOME/.zsh_ownrc;then
	. $HOME/.zsh_ownrc
fi

# Ctrl + Dでログアウトされることを防ぐ
#setopt IGNOREEOF

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
compinit

autoload -Uz add-zsh-hook
autoload -Uz terminfo
autoload -Uz is-at-least

#補完後に十字キーで選択
zstyle ':completion:*:default' menu select=2
# 大文字も補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#Setting of History
#他のターミナルとの履歴の共有
setopt share_history
# 重複は表示しない
setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

#editor
export EDITOR=vim

#色
autoload -Uz colors
colors

setopt no_tify
setopt extended_glob

# どこからでも参照できるディレクトリパス ~/bin等
cdpath=()

#パス通す
export PATH="$PATH:/sbin"

# cdしたあとで、自動的に tree する(treeが泣ければls)
if type "colorls" >/dev/null 2>&1;then
	function chpwd(){ 
		if test `ls $(pwd)| wc -w` -gt 10;then
			tree --charset=C -L 1
		else
			colorls --tree
		fi}
elif type "tree" >/dev/null 2>&1;then
	function chpwd() { tree --charset=C -L 1; }
else
	function chpwd() { ls; }
fi

#deleteを使えるように
bindkey "^[[3~" delete-char #これをコメントアウトすると、deleteで大文字になってしまう

#vim mode
bindkey -v

#Setting of z.sh
test -f ~/bin/z/z.sh && source ~/bin/z/z.sh
alias clearz="rm -rf ~/.z && touch ~/.z"

#Setting of pushd
setopt auto_pushd #自動でpushd実行
setopt pushd_ignore_dups #重複削除

#Setting of alias
alias vz="vim ~/.zshrc"
alias vzo="vim ~/.zsh_ownrc"
alias vv="vim ~/.vimrc"


#ls系
if type "colorls" >/dev/null 2>&1;then
	alias ls="colorls --sd"
	alias l="colorls --sd -lA --report"
	alias la="colorls --sd -al --report"
	alias ll="colorls --sd -Al --report"
	alias ld="colorls -d"
	alias lf="colorls -f"
else
	alias ls="ls -FX --color=auto"
	alias l="ls -FXSlth --color=auto"
	alias la="ls -FSXlha --color=auto"
	alias ll="ls -FSXlh --color=auto"
fi
#alias lst="ls -lhtr --color=auto"

# clear系
alias clear2="echo -e '\026\033c'" #バイナリファイルcatしたときの文字化け修正
alias clearcookie="rm -rf ~/.w3m/cookie && touch ~/.w3m/cookie "
alias clearhistory="rm -rf ~/.w3m/history && touch ~/.w3m/history "
alias clearw3m="clearcookie && clearhistory" #上2つの統合版
alias cleartrash="rm -rf ~/.local/share/Trash/files/*" #ゴミ箱カラ

#xselをインストールしといて
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

alias his="history 0"

#git系
if type "colorls" >/dev/null 2>&1;then
	alias gs="colorls --gs -A"
	alias gst="colorls --gs -tA"
else
alias gs="git status"
fi
alias ga="git add ."
alias gp="git push"

alias mkdir="mkdir -p"

alias pacman="myman"

#sl
alias dir="sl2" #sl2はslのnewバージョン/usr/local/bin/sl2にリンク貼ってる

alias ...="cd ../../"

#コマンドプロンプトの設定
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color} %~
%# "

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

setopt prompt_subst
#コマンド実行前に呼ばれる関数
precmd(){
	RPROMPT="`prompt-git-current-branch`"
}

#入力された文字列を赤色にして返す(パイプ対応)
function reds(){
	case $1 in
		--help|-h)
			printf "\033[31m\033[1m%s\033[m\n"  "This is a program that echo red colored strings."
			echo ""
			echo [Usage]
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


# %h history番号 -->でクリップボードに対応するコマンドをコピー -->Ctrl+Shift+vで貼り付けられる
function h(){
	history $1 | sed -n 1P|awk '{$1=""; print}' | tr -d "\n"| sed -e 's/^[ ]*//g' | pbcopy #trで改行捨ててるからコマンドの修正も簡単 素の次のsedで行頭の空白削除
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

#dot [str]
function dot(){
	echo -n $1
	while :;do
		echo -ne "."
		sleep 0.2
	done
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

# 引数に検索したい文字列を入れる(空白を含む場合は""でかこう) --> w3mでgoogle検索
function what(){
	case $1 in
		--help|-h)
			echo Usage
			echo "what [keyworld]  -->google search"
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
	distro=`cat /etc/lsb-release|grep 'DISTRIB_DESCRIPTION'|sed 's/DISTRIB_DESCRIPTION=//'|tr -d ' '|tr -d '"'`
elif test -f /etc/debian_version;then
	distro=Debian`cat /etc/debian_version`
else
	distro=`uname`
fi

printf "\033[31m\033[1m\033[4m%s\033[m\n" "`zsh --version|awk '{$3=""; print}'|tr -d " "`@`echo $distro|tr -d " "`"
