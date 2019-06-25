#!/bin/bash
#Author:mizoc <yaesuft729@gmail.com>
#Licence:MIT
set -u
export LANG=C
export LC_ALL=C
cd `dirname $0`
path=`pwd`

#Make zshownrc
test -f $HOME/.zsh_ownrc || cat << END >> $HOME/.zsh_ownrc
#This is your ~/.zsh_ownrc.
#This file will load automaly when zsh started.
#You can open this file by %vzo on zsh.
END

#make dirs
mkdir -p $HOME/src
mkdir -p $HOME/bin

#vim-plug
echo -n "Downloading vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && echo done

#zplug
echo -n "Downloading zplug..."
export ZPLUG_HOME=~/.zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME && echo done

echo -n "Downloading fonts for vim..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf && echo done
cd

#git tree
git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'

source  $path/update.sh

#Last msg
echo 
echo "OK. Finished every settings."
echo 'Now, execute ./install.sh && vim and execute :pluginstall'


# stty -echo
# echo -n "[sudo] Password:"
# read password
# stty echo
# echo
#
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
