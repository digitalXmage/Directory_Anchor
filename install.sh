#!/bin/bash
gcc src/anchor.c config/config.h -o anchor
sudo mv anchor /usr/bin/
rm ~/.anchor;touch ~/.anchor
cp ~/.bashrc ~/.bashrc.backup
