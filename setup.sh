#! /bin/bash

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

ln -sf ./vimrc ~/.vimrc
ln -sf ./vim ~/.vim
ln -sf ./zshrc ~/.zshrc
ln -sf ./zshrc.pre-oh-my-zsh  ~/.zshrc.pre-oh-my-zsh
ln -sf ./gitconfig ~/.gitconfig
