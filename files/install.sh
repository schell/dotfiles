#!/bin/bash

for f in .*
do
    echo "Hard linking $f to ~/$f..."
    ln $f ~/$f
done

echo "Installing vim vundle..."

mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim ~/.vimrc +BundleInstall! +BundleClean +qall
git config --global user.name "Schell Scivally"
git config --global user.email "efsubenovex@gmail.com"
git config --global core.editor vim

echo "Done!"
