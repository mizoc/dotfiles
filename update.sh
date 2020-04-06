#!/bin/bash
#Author:mizoc <yaesuft729@gmail.com>
#Licence:MIT
set -u
export LANG=ja_JP.UTF-8
export LC_ALL=C
cd `dirname $0`
path=`pwd`

echo

if test ! `hostname` = 'solus';then
# if test ! `hostname` = 'taichi_Linux';then
	echo Downloading new version...
	git fetch origin master
	git reset --hard origin/master
fi

for i in .??* ;do
	[ "$i" = ".git" ] && continue
	ln -sf "$path/$i" "$HOME"/"$i"
done && ln -fs "$path/terminator-config" "$HOME/.config/terminator/config" && echo 'done' || echo failed
