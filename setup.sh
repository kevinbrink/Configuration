#! /bin/bash

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -sf $PWD/vimrc ~/.vimrc
ln -sf $PWD/vim ~/.vim
ln -sf $PWD/zshrc ~/.zshrc
ln -sf $PWD/zshrc.pre-oh-my-zsh  ~/.zshrc.pre-oh-my-zsh
ln -sf $PWD/gitconfig ~/.gitconfig
