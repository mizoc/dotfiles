#!/bin/bash
set -u
export LANG=C
export LC_ALL=C
cd `dirname $0`
path=`pwd`
stty -echo
echo -n "[sudo] Password:"
read password
stty echo
echo

function dotwait(){
	echo -n $1
	while :;do
		echo -ne "."
		sleep 0.5
	done
}

which pip >/dev/null 2>&1
if [ $? -ne 0 ];then
	echo "Installing pip..."
	echo "$password"|sudo -S python3 -m pip install pip
fi

#pip packages
echo "$password"|sudo -S pip install -r "$path/requirements.txt" >/dev/null 2>&1&
pid=$!
echo Downloading python packages
dotwait "It may take a minutes" &
dot_pid=$!
wait $pid
kill $dot_pid
echo 'done'

#vim-plug
echo -n "Downloading vim-plug..."
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && echo done
echo 'done'
#Last msg
echo 
echo "OK. Finished every settings."
echo 'Now, execute ./install.sh && vim and execute :pluginstall'
