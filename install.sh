#!/bin/bash

# vim stuff
mkdir -p ~/.vim/colors
curl --silent --location --output ~/.vim/colors/alduin.vim https://raw.githubusercontent.com/AlessandroYorba/Alduin/master/colors/alduin.vim
ln -f ./vimrc ~/.vimrc

# bashrc
ln -f ./bashrc ~/.bashrc

