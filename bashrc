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

##### DOCKER ######

# Docker-related shortcut functions

# Open bash to web
function docker_web () {
  docker exec -it `docker ps -alq -f "name=web"` bash
}

# Open bash to postgres
function docker_postgres () {
  docker exec -it $(docker ps -alq -f "name=postgres") bash
}

function docker_rmi () {
  IMAGE_NAME=$1
  docker images -q | while read IMAGE_ID; do
    if [[ $(docker inspect --format='{{.RepoDigests}}' $IMAGE_ID) == *"$IMAGE_NAME"* ]]; then
      docker rmi -f $IMAGE_ID
    elif [[ $(docker inspect --format='{{.RepoTags}}' $IMAGE_ID) == *"$IMAGE_NAME"* ]]; then
      docker rmi -f $IMAGE_ID
    fi
  done
}

function local_swarm_setup () {
  set -e
  # Set up a local swarm using docker-machine.
  # Uses your local machine as the primary manager node inside the swarm, and creates a few `docker-machine` nodes to serve in various other roles
  echo -n "Creating machines... "
  NODES=(primary-manager worker db-primary db-secondary)
  for NODE in ${NODES[@]}; do
    if [ -n "$(docker-machine ls -q | grep $NODE)" ]; then
      echo "Node \"$NODE\" already exists; skipping..."
      continue
    fi
    docker-machine create --driver xhyve $NODE
  done
  echo "Done."

  echo -n "Creating swarm on primary-manager node... "
  docker-machine ssh primary-manager docker swarm init --advertise-addr eth0:2377 || true
  echo "Done."

  JOIN_COMMAND=$(docker-machine ssh primary-manager docker swarm join-token worker | awk 'FNR == 3')

  #echo -n "Setting up local machine as manager in the swarm... "
  #$JOIN_COMMAND

  #docker-machine ssh primary-manager docker node promote moby
  #sleep 1
  #docker node update --label-add role=secondary_manager moby
  #echo "Done."

  echo -n "Setting up other nodes; joining swarm, updating labels... "
  for NODE in ${NODES[@]}; do
    docker-machine ssh $NODE $JOIN_COMMAND || true
    docker-machine ssh primary-manager docker node update --label-add role="$NODE" $NODE
  done
  echo "Done."
  echo "Here's the current swarm:"
  docker node ls
}

##### CFPS ######

function cfps_init () {
  set -e
  sudo ./cfps_init.sh
  cfps image --build
  cfps build initialize_db
  cfps build taser all
  cfps build libwxapi
  cfps build lightning
  cfps build less
}

function cfps_pull () {
  git checkout develop &&
  git pull &&
  cfps compose down &&
  cfps image --build &&
  cfps build libwxapi &&
  cfps build lightning &&
  cfps compose -sv up -d aftn balancer cache db_pool db_primary db_secondary lightning metpxfeed proxy queue_primary weather weather_worker web web_worker websocket &&
  cfps web migrate &&
  cfps weather migrate
}

function cfps_create_weather () {
  cfps weather direct create_datalayers
  cfps weather direct create_datalink_stations_and_outages
  cfps weather direct create_intersections
  cfps weather direct create_lightning
  cfps weather direct create_metars
  cfps weather direct create_nattracks
  cfps weather direct create_pireps
  cfps weather direct create_sigmets
  cfps weather direct create_tafs
  cfps weather direct create_upper_wind
}

function cfps_time_fresh_image_build () {
	cfps compose down
	docker container prune -f
	docker rmi -f $(docker images -q)
	time cfps image --build
  docker images --format "{{.Size}}" --filter "reference=cfps/*1.0"
}

function prettier_cfps () {
  if [ $# -eq 0 ]
    then
      action='--list-different'
  else
    action=$1
  fi
  cfps compose run debug_react prettier $action src/**/*.{js,css}
}

function flake8_docker () {
  existing=$(docker ps --filter name=flake8 -q)
  # If we don't have one yet
  if [ -z $existing ]; then
    docker run --entrypoint bash -d --name flake8 -v $(pwd):/target -v /Users/Kevin/Code/cfps-app/source/flake8.config:/flake8.config flake8
  fi
  docker exec -it $(docker ps -q --filter name=flake8) flake8 --config /flake8.config $@
}

function create_ramdisk () {
  # This creates a 4GB ramdisk called "ram_disk"
  diskutil erasevolume HFS+ 'ram_disk' `hdiutil attach -nomount ram://8388608`
  mkdir /Volumes/ram_disk/data
}

##### VMWare ######

function command_vms() {
  COMMAND=$1
  VM_LOCATION="~/VMware/VM\'s/"
  shift
  while :; do
    case $1 in
      "")
        break
      ;;
      *)
        /Applications/VMware\ Fusion.app/Contents/Library/vmrun $COMMAND ~/VMware/VM\'s/$1.vmwarevm
      ;;
    esac
    shift
  done
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

# Add git prompt
source ~/.git-prompt.sh
PS1="\[$(tput setaf 2)\]\D{%a %m %d %I:%M}|\w\\[$(tput bold)\]\$(__git_ps1)\[$(tput sgr0)\]:"
