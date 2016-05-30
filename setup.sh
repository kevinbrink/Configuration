#! /bin/bash

# TODO: Fix these:
ln -s ./vimrc ~/.vimrc
ln -s ./vim ~/.vim
ln -s ./bashrc ~/.bash_profile
ln -s ./haml-lint.yml ~/.haml-lint.yml

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
