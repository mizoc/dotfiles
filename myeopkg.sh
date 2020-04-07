#!/bin/sh
sudo eopkg update-repo
sudo eopkg -y install zsh terminator make rofi git
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/im/skype/pspec.xml
sudo eopkg it skype*.eopkg;sudo rm *.eopkg
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/multimedia/music/spotify/pspec.xml
sudo eopkg it spotify*.eopkg;sudo rm spotify*.eopkg
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/im/slack-desktop/pspec.xml
sudo eopkg it slack-desktop*.eopkg;sudo rm slack-desktop*.eopkg
sudo eopkg -y install -c system.devel
sudo eopkg -y install w3m conky discord mplayer ibus-mozc ibus-anthy anthy
sudo eopkg -y it --reinstall alsa-firmware alsa-lib alsa-lib-32bit alsa-plugins alsa-plugins-32bit alsa-tools alsa-utils
sudo eopkg -y install fzf llvm-devel ruby-devel tmux moreutils python-devel python3-devel fcitx docker openssh dropbox aria2 fontforge
