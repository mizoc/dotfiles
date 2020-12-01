#!/bin/bash
#Author:mizoc <yaesuft729@gmail.com>
#Licence:MIT
set -u
export LANG=ja_JP.UTF-8
export LC_ALL=C
cd $(dirname $0)
path=$(pwd)

echo

echo Uninstalling...

if test ! $(hostname) = 'mizoc-debian'; then
  for i in .??*; do
    unlink "$HOME"/"$i"
  done
  rm -rf ~/.dotfiles
fi
