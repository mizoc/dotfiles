#!/bin/bash
#Author:mizoc <yaesuft729@gmail.com>
#Licence:MIT
set -u
export LANG=C
export LC_ALL=C
cd `dirname $0`
CURRENT_PATH=`pwd`

type "espeak" >/dev/null 2>&1 && espeak "Thank you for installing my dotfiles." ; clear
#print msg
cat << END
      __      __  _____ __
  ____/ /___  / /_/ __(_) /__  _____
 / __  / __ \/ __/ /_/ / / _ \/ ___/
/ /_/ / /_/ / /_/ __/ / /  __(__  )
\__,_/\____/\__/_/ /_/_/\___/____/
END

#Make zshownrc
test -f $HOME/.zsh_ownrc || cat << END >> $HOME/.zsh_ownrc
#This is your ~/.zsh_ownrc.
#This file will load automaly when zsh started.
#You can open this file by %vzo on zsh.
END

#make dirs
mkdir -p $HOME/src
mkdir -p $HOME/bin
mkdir -p $HOME/tmp

#vim-plug
echo "Downloading vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && echo 'done'

#zplug
echo "Downloading zplug..."
export ZPLUG_HOME=~/.zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME && echo 'done'

echo "Downloading fonts for vim..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf && echo 'done'
cd

echo "Downloading tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#git tree
git config --global core.pager "more" #エスケープコード認識
git config --global core.quotepath "false" #日本語文字化け対策
git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'

#ln dotfiles
cd $CURRENT_PATH
./update.sh

#Last msg
echo
echo "OK. Finished all settings."
echo 'Now, excute vim and :pluginstall'
echo You should install GNU source-highlight

# stty -echo
# echo -n "[sudo] Password:"
# read password
# stty echo
# echo
# gem install colorls
# function dotwait(){
# 	echo -n $1
# 	while :;do
# 		echo -ne "."
# 		sleep 0.5
# 	done
# }
#
# which pip >/dev/null 2>&1
# if [ $? -ne 0 ];then
# 	echo "Installing pip..."
# 	echo "$password"|sudo -S python3 -m pip install pip
# fi
#
# #pip packages
# echo "$password"|sudo -S pip install -r "$path/requirements.txt" >/dev/null 2>&1&
# pid=$!
# echo Downloading python packages
# dotwait "It may take a minutes" &
# dot_pid=$!
# wait $pid
# kill $dot_pid
# echo 'done'
