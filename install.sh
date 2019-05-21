#!/bin/bash
set -u
export LANG=C
export LC_ALL=C
cd `dirname $0`
path=`pwd`

for i in .??* ;do
	[ "$i" = ".git" ] && continue
	ln -sf "$path/$i" "$HOME"/"$i"
done
echo 'done'
