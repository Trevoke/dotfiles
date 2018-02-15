#!/bin/bash

path=$HOME/src/projects/dotfiles

touch $HOME/.profile

for i in bin .bash_login .bash_profile .bashrc .config .dotrc .git_template .gitconfig .gitignore_global .globalrc .pryrc .tmux .tmux-powerlinerc .tmux.conf .zlogin .zshrc
do
    ln -sf $path/$i $HOME/$i
done