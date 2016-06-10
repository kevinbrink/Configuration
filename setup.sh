#! /bin/bash

# TODO: Fix these:
ln -sf $PWD/vimrc ~/.vimrc
ln -sf $PWD/vim ~/.vim
ln -sf $PWD/bashrc ~/.bash_profile
ln -sf $PWD/haml-lint.yml ~/.haml-lint.yml
ln -sf $PWD/gitconfig ~/.gitconfig

# Create folder for persistent undo
mkdir ~/.vim/undo
# Overkill, but it works:
chmod 777 ~/.vim/undo

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
