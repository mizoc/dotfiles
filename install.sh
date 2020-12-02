#!/bin/bash
#Author:mizoc <yaesuft729@gmail.com>
#Licence:MIT

#DL
git clone https://github.com/mizoc/dotfiles ~/.dotfiles
if [ $? -ne 0 ]; then
    echo "Error cannot download via git"
    exit 1
fi

cd ~/.dotfiles
set -u
export LANG=C
export LC_ALL=C
CURRENT_PATH=~/.dotfiles

#show msg
type "espeak" >/dev/null 2>&1 && espeak "Thank you for installing my dotfiles."
clear
cat <<END
      __      __  _____ __
  ____/ /___  / /_/ __(_) /__  _____
 / __  / __ \/ __/ /_/ / / _ \/ ___/
/ /_/ / /_/ / /_/ __/ / /  __(__  )
\__,_/\____/\__/_/ /_/_/\___/____/
END

#Make zshownrc
test -f $HOME/.zsh_ownrc || cat <<END >>$HOME/.zsh_ownrc
#This is your ~/.zsh_ownrc.
#This file will load automaly when zsh started.
#You can open this file by %vzo on zsh.
END

#make dirs
mkdir -p $HOME/src
mkdir -p $HOME/bin
mkdir -p $HOME/tmp
mkdir -p $HOME/go
mkdir -p $HOME/.config/terminator
mkdir -p $HOME/.config/rofi
mkdir -p $HOME/.config/i3

#link dotfiles
cd $CURRENT_PATH
./update.sh

#python pkgs
sudo python3 -m pip install --upgrade pip
sudo pip install -r $CURRENT_PATH/python-pkgs.txt

#if has any package manager, install my favorit pkgs
which test 'eopkg' >/dev/null 2>&1
if test $? -eq 0; then
  sh $CURRENT_PATH/myeopkg.sh
fi
which test 'apt' >/dev/null 2>&1
if test $? -eq 0; then
  sh $CURRENT_PATH/myapt.sh
fi

#vim-plug
echo "Downloading vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && echo 'done'

#z.sh
git clone https://github.com/rupa/z.git $HOME/src/z

#zinit
echo "Downloading zinit..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)" && echo done

#font
echo "Downloading fonts for vim..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf && echo 'done'
cd

#tmux
echo "Downloading tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Downloading tmux-powerline"
git clone git://github.com/erikw/tmux-powerline.git ~/.tmux-powerline

#shfmt
echo "Downloading shell formatter..."
go get -u github.com/mvdan/sh/cmd/shfmt

#git setting
git config --global core.pager "more"      #エスケープコード認識
git config --global core.quotepath "false" #日本語文字化け対策
git config --glob alias.tree 'log --graph --pretty=format:"%x09%C(auto) %h %Cgreen %ar %Creset%x09by \"%C(cyan ul)%an%Creset\" %x09%C(auto)%s %d"'
git config --global pretty.medium-reverse "format:%C(red reverse)%d%Creset%C(white reverse) %h% Creset %C(green reverse) %an %Creset %C(cyan)%ar%Creset%n%C(white bold)%w(80)%s%Creset%n%n%w(80,2,2)%b"
git config --global alias.tags "tag -l"
git config --global alias.branches 'branch -a'
git config --global alias.cm 'commit'
git config --global alias.st 'status -sb'
git config --global commit.template ~/.commit_template


#DL vim
[ -f ~/src/vim ] || git clone https://github.com/vim/vim ~/src/vim
#vim configure option
# ./configure --prefix=/usr/local  --with-features=huge  --enable-multibyte  --enable-perlinterp  --enable-terminal  --enable-python3interp  --enable-rubyinterp  --enable-luainterp  --with-luajit  --enable-fail-if-missing --enable-gui=gtk2

#Last msg
echo OK, installed.
echo Checking pkgs...
bash $CURRENT_PATH/check.sh
test -n $ZSH_VERSION && exec `which zsh`
