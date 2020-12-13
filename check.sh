#!/bin/bash
#Author:mizoc <yaesuft729@gmail.com>
#Licence:MIT
function show_ng(){
    echo "❌ $*"
}

function show_ok(){
    echo "✔  $*"
}

#with version(line 1)
while read LINE
do
  if type "$LINE" >/dev/null 2>&1;then
    show_ok `$LINE --version|sed -n 1p`
  else
    show_ng $LINE
  fi
done <<END
conky
gh
mpv
END

#with version and name
while read LINE
do
  if type "$LINE" >/dev/null 2>&1;then
    show_ok $LINE `$LINE --version`
  else
    show_ng $LINE
  fi
done <<END
fzf
gem
END

#with version
while read LINE
do
  if type "$LINE" >/dev/null 2>&1;then
    show_ok `$LINE --version`
  else
    show_ng $LINE
  fi
done <<END
git
firefox
zsh
alacritty
vagrant
black
terminator
ruby
pip
python3
END

#特殊
if type "go" >/dev/null 2>&1;then
  show_ok `go version`
else
  show_ng go
fi


#without version
while read LINE
do
  if type "$LINE" >/dev/null 2>&1;then
    show_ok $LINE
  else
    show_ng $LINE
  fi
done <<END
python
vim
curl
wget
ssh
peco
gcc
g++
rofi
simplenote
ffmpeg
skypeforlinux
discord
slack
END

