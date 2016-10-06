#! /bin/bash

brew install ctags
ctags -R -f ~/Code/tags ~/Code/ --exclude="@exclude.txt"
