# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -1'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue) <%an>%Creset' --abbrev-commit --branches"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#======================   fayez-Defined Commands   ========================

Color_Reset='\033[0m'       # Text Reset
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

#echo "                                      Bismillahir Rahmanir Rahim              "
#echo ""
#echo ""
#neofetch

#echo "
#                     ▒█░▒█ █▀▀ █░░ █░░ █▀▀█ 　 ▒█░░▒█ █▀▀█ █▀▀█ █░░ █▀▀▄ 
#                     ▒█▀▀█ █▀▀ █░░ █░░ █░░█ 　 ▒█▒█▒█ █░░█ █▄▄▀ █░░ █░░█ 
#                     ▒█░▒█ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀▀ 　 ▒█▄▀▄█ ▀▀▀▀ ▀░▀▀ ▀▀▀ ▀▀▀░
#"

#alias jupyter='gnome-terminal -- jupyter "$@"';
alias ping='ping -c 5'
alias tree='tree -L 2'
alias lsdir='tree -d -L 2'

launch_yazi()
{
    ghostty --title=Yazi --window-height=40 --window-width=160 --background-opacity=0.95 -e yazi
}

vimn()
{
   alacritty -qq --config-file ~/.config/alacritty/vim_config.toml -T "nvim - $@" -e nvim "$@" & 
}

createFiles()
{
# $@ selects all the arguments
# $# says the total number of arguments passed
# ${@:start_pos:end_pos} used in this format for slicing

    touch "${@:1:$#-1}";

    if [[ "${@:$#}" == 'c' ]]
    then
        code "${@:1:$#-1}";
        
    elif [[ "${@:$#}" == 'v' ]]
    then
        vimn -p "${@:1:$#-1}";

    fi
}


mkdirc()
{
    mkdir -p  "$@";
    cd $_;
}


syncpac()
{
    sudo apt-get update && sudo apt-get -y upgrade;
}

activateenv()
{
    if [ ! -f ./.venv/*/bin/activate ]; then
        echo -e "${Red}Environment activate script not available.${Color_Reset}"
        return
    fi
	source ./.venv/*/bin/activate
}

createEnv()
{
    if [ $# -eq 0 ] 
    then
        echo -e "${Yellow}Environment name required.${Color_Reset}"
        return
    fi

    python3 -m venv --clear ./.venv/$1;
    activateenv;

    if [ -f ./requirements.txt ]
    then
        echo -e "\n\033[1;32mINSTALLING REQUIREMENTS\n\033[0m"
        pip3 install --requirement ./requirements.txt
    fi

}


runp()
{
    echo -e "\n\033[1;32mEXECUTING APPLICATION:\n\033[0m"

    file_name=$(find ./build/ -maxdepth 1 -executable -type f);
    $file_name
}


crprs()
{
    file_name=${PWD##*/}

    cp ./../templates/template.cpp "${file_name}.cpp"
    createFiles "${file_name}.cpp" "${file_name}.py" v;
}

cpclip()
{
    more "${1}" | xclip -selection clipboard
}

runlab()
{
    gnome-terminal -- jupyter lab --browser=firefox &
}

createProject()
{
    if [ -z $1 ]
    then
        echo -e "${Red}PROJECT NOT CREATED.${Color_Reset}"
        echo "[REQUIRED]: Project Name."
        return
    fi

    mkdir -p "$1"/{build,src,include/"$1"}
    cd "$1"
    touch main.cpp CMakeLists.txt

#     echo -e \
# """
# #!/bin/bash
# CXX=g++
# CPPFLAGS=-I\$(include_dir)
# build_dir = ./build
# src_dir = ./src
# include_dir = ./include
# srcs = \$(shell find ./ -type f -name '*.cpp' )
# objs = \$(srcs:.cpp=.o)
#
# all: \$(build_dir) \$(build_dir)/${1}
#
# debug: CXX += -g 
# debug: clean \$(build_dir) \$(build_dir)/${1}
#
# \$(build_dir)/${1}: \$(build_dir) \$(objs)
# \t\$(CXX) \$(CPPFLAGS) \\
# \t        \$(objs) \\
# \t        -o \$(build_dir)/${1}
#
# \$(build_dir):
# \tmkdir ./build
#
# clean: 
# \t-rm ./*.o
# \t-rm \$(src_dir)/*.o
# \t-rm \$(build_dir)/*
# """ >> Makefile
#
    echo -e \
"""
# Generated by createProject command
# change as required

cmake_minimum_required(VERSION 3.20)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_EXPORT_COMPILE_COMMANDS True)

project(${1}
    DESCRIPTION "description_will_be_changed_later"
    VERSION 0.0.1
    LANGUAGES CXX
)

file(GLOB ${1}_SRC_FILES "./src/*.cpp")

add_executable(\${PROJECT_NAME}
    main.cpp
    \${${1}_SRC_FILES}
)

""" >> ./CMakeLists.txt
    
    # check for the availability of template file mainfile.temp
    if [ -f ~/Templates/mainfile.temp ]; then 
        cp ~/Templates/mainfile.temp ./main.cpp
    else
        echo -e "${Yellow}[WARN] ${Color_Reset}Template file(mainfile.temp) not found."
    fi

    # check for the availability of the command clang-format
    if ! command -v clang-format 2>&1 >/dev/null; then
        echo -e "${Yellow}[WARN] ${Color_Reset}clang-format is not installed."
    else
        clang-format --style WebKit --dump-config > .clang-format
    fi

    echo -e "${Green}[CREATED PROJECT] $1.${Color_Reset}"
}

source_ros()
{
    source /opt/ros/${ROS_DISTRO}/setup.bash
    source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
    export ROS_DOMAIN_ID=1
}




# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> END <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

. "$HOME/.cargo/env"
eval "$(fzf --bash)"
