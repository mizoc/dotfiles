#!/bin/bash
#Author:mizoc <yaesuft729@gmail.com>
#Licence:MIT
set -u
export LANG=ja_JP.UTF-8
export LC_ALL=C
cd `dirname $0`
path=`pwd`

if test !`hostname` = 'taichi_Linux';then
	git fetch origin master
	git reset --hard origin/master
fi

for i in .??* ;do
	[ "$i" = ".git" ] && continue
	ln -sf "$path/$i" "$HOME"/"$i"
done && echo 'done' || echo failed
