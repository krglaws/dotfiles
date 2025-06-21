#!/bin/bash

FULLPATH=$(cd $(dirname $0) && pwd)

# vim stuff
ln -fs "${FULLPATH}/vimrc" ~/.vimrc

# bashrc
ln -fs "${FULLPATH}/bashrc" ~/.bashrc

