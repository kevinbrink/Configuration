# TODO: Remove this? source /Users/kevyboy014/perl5/perlbrew/etc/bashrc

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

#alias vim='nvim -p'
alias vim='vim -p'
alias gitstat='git status -uno --short | grep -Po "\S+$"' # This should print out ONLY the files that were changed; can then be pumped into vim or what have you
alias gitdiff='git diff --color=always'
alias gitvimdiff='git difftool --no-prompt' # Shortcut to use vimdiff to view differences
alias ls_orig="ls"
alias ls="ls -laG"
alias lt="ls -latG"
#alias locate="mdfind"
alias diff_orig="diff"
alias diff="diff -i -w -y --suppress-common-lines"
alias grep="grep --color=auto"

# This is a handy little shortcut to tokenize a file; used at Miralaw
alias tokenize="java -cp ~/Current/Stanford\ NLP/stanford-ner-2015-04-20/stanford-ner.jar edu.stanford.nlp.process.PTBTokenizer"

alias work="~/.bash_scripts/work.sh"

# For school
alias packetTrace='sudo tcpdump -i en1 -s 0 -B 524288 -w'
alias readPacketTrace='tcpdump -s 0 -n -e -x -vvv -r'

# Little function for git completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Function for vim; it checks to see if we should use sudo or not, and opens with multiple tabs

function custom_vim () {
    # TODO Need to check here for if we need sudo
    vim -p $@
}

# Functions for compiling various languages:

function compile_c () {
  gcc $1.c -o $1.o -g -pedantic
}

function compile_java () {
  javac $1
}

# Function to setup a basic java project using gradle
function java_init () {
    gradle init
    echo "// Apply the java plugin to add support for Java
apply plugin: 'java'

// Set the name of the main class
mainClassName = 'Main'

// Define the repositories being used
repositories {
    jcenter()
}

dependencies {
    // Examples: 
    //compile 'edu.stanford.nlp:stanford-corenlp:3.5.1'
}" > build.gradle
    mkdir src
    mkdir src/main
    mkdir src/main/java
    echo "public class Main {
    public static void main(String[] args) {
    }   
}" > src/main/java/Main.java
    vim src/main/java/Main.java
}


# Add the valgrind to the path
#export PATH=$PATH:/Users/kevyboy014/Dropbox/School/Algonquin/Software/Valgrind/bin

# Note: Here are some extra settings that I wasn't using on my laptop, but might
# come in handy later on:

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls -la --color=auto'
#    #alias dir='dir --color=auto'
#    #alias vdir='vdir --color=auto'
#
#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi
#
## Some putty-specific stuff
#
#stty ixany
#stty ixoff -ixon
#stty stop undef
#stty start undef
#
## uncomment for a colored prompt, if the terminal has the capability; turned
## off by default to not distract the user: the focus in a terminal window
## should be on the output of commands, not on the prompt
##force_color_prompt=yes
#
#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#	# We have color support; assume it's compliant with Ecma-48
#	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi
#
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Added by me for the postgres commands
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
export PGDATA="/Users/Kevin/Library/Application Support/Postgres/var-9.4"

# Add git prompt
source ~/.git-prompt.sh
PS1="\\[$(tput setaf 2)\\]\d|\\w\\[$(tput sgr0)\\]\$(__git_ps1):"

# From Marc, for Docker stuff:
eval "$(direnv hook $0)"
export PATH="/usr/local/sbin:$PATH"
