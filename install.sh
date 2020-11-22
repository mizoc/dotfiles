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
mkdir -p $HOME/go

#vim-plug
echo "Downloading vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && echo 'done'

#z.sh
git clone https://github.com/rupa/z.git $HOME/src/z

#zplugin
echo "Downloading zplugin..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)" && echo done

echo "Downloading fonts for vim..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf && echo 'done'
cd

echo "Downloading tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Downloading tmux-powerline"
git clone git://github.com/erikw/tmux-powerline.git ~/.tmux-powerline

#git setting
git config --global core.pager "more" #エスケープコード認識
git config --global core.quotepath "false" #日本語文字化け対策
git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'
git config --global alias.tags "tag -l"
git config --global alias.branches 'branch -a'
git config --global alias.cm 'commit'
git config --global alias.st 'status -sb'

#emoji commit template
git clone https://gist.github.com/Jung0/56d527ed5d2c783661f7d56c46332308 ~/src/commit_template
git config --global commit.template ~/src/commit_template/.commit_template

#ln dotfiles
cd $CURRENT_PATH
./update.sh

#compile C/CXX functions
test "$CURRENT_PATH" = "" || rm -rf "$CURRENT_PATH/bin/"; mkdir "$CURRENT_PATH/bin/"
(cd $CURRENT_PATH/src;make clean; make && make install)

#python pkgs
sudo python3 -m pip install --upgrade pip
sudo pip install -r $CURRENT_PATH/python-pkgs.txt

#if solus, eopkg
which 'eopkg' >/dev/null 2>&1
if $? -eq 0;then
	sh $CURRENT_PATH/myeopkg.sh
fi

which 'apt' >/dev/null 2>&1
if $? -eq 0;then
	sh $CURRENT_PATH/myapt.sh
fi

#Last msg
echo
echo "OK. Finished all settings."
echo 'Now, excute vim and :pluginstall and $zplug install'
echo You should install GNU source-highlight

#vim configure option
# ./configure --prefix=/usr/local  --with-features=huge  --enable-multibyte  --enable-perlinterp  --enable-terminal  --enable-python3interp  --enable-rubyinterp  --enable-luainterp  --with-luajit  --enable-fail-if-missing --enable-gui=gtk2
