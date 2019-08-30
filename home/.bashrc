# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# cf.
# [ -z "$PS1" ] && return

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

# cf.
# if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# color-coding by machine
reset=$(tput sgr0)
red=$(tput setaf 1)
blue=$(tput setaf 4)
green=$(tput setaf 2)
base_prompt="\u@\h:\w\$ "
case "$HOSTNAME" in
gelato)
    # Red for gelato
    base_prompt="\[${red}\]${base_prompt}\[${reset}\]"
    ;;
*)
    # No color
    ;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}'${base_prompt}
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    if [ -r ~/.dircolors.ansi-universal ]; then
	eval "$(dircolors -b ~/.dircolors.ansi-universal)"
    elif [ -r ~/.dircolors ]; then
	eval "$(dircolors -b ~/.dircolors)"
    else
	eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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

## GCS Custom stuff
export PATH=$PATH:$HOME/bin

export DEBFULLNAME='Gregory C. Sharp'
export DEBEMAIL='gregsharp.geo@yahoo.com'

#if [ -f ~/work/plastimatch/extra/gcs6/set_path.sh ]; then
#    . ~/work/plastimatch/extra/gcs6/set_path.sh
#fi

if [ -f ~/bin/set_path.sh ]; then
    source ~/bin/set_path.sh
fi

if [ -d $HOME/.opam/system/bin ]; then
    PATH=$PATH:$HOME/.opam/system/bin
    export PATH
    # OPAM configuration
    #. /PHShome/gcs6/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
fi

# EGS
export EGS_CONFIG="$HOME/build/EGSnrc/HEN_HOUSE/specs/linux64.conf"
export EGS_HOME="$HOME/build/EGSnrc/egs_home"
alias "egs=source ~/build/EGSnrc/HEN_HOUSE/scripts/egsnrc_bashrc_additions"

# FLUKA
export FLUPRO=$HOME/build/fluka2011.2b.6

# TOPAS
if [ -d $HOME/topas ]; then
    export G4LEDATA=~/G4Data/G4EMLOW6.48
    export G4NEUTRONHPDATA=~/G4Data/G4NDL4.5
    export G4LEVELGAMMADATA=~/G4Data/PhotonEvaporation3.2
    export G4RADIOACTIVEDATA=~/G4Data/RadioactiveDecay4.4
    export G4SAIDXSDATA=~/G4Data/G4SAIDDATA1.1
    export G4NEUTRONXSDATA=~/G4Data/G4NEUTRONXS1.4
    export G4PIIDATA=~/G4Data/G4PII1.3
    export G4REALSURFACEDATA=~/G4Data/RealSurface1.0
    export G4ABLADATA=~/G4Data/G4ABLA3.0
    export G4ENSDFSTATEDATA=~/G4Data/G4ENSDFSTATE1.2.1
    export G4TENDLDATA=~/G4Data/G4TENDL1.0
    export LD_LIBRARY_PATH=~/topas/libexternal/:$LD_LIBRARY_PATH
    PATH=$PATH:$HOME/topas
    export PATH
fi

# VW
if [ -d $HOME/build/src/vowpal_wabbit/vowpalwabbit ]; then
    PATH=$PATH:$HOME/build/src/vowpal_wabbit/vowpalwabbit
    export PATH
fi

# Quilt
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
complete -F _quilt_completion $_quilt_complete_opt dquilt

# CUDA
case "$HOSTNAME" in
sherbert)
    #export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-9.0/lib64:/usr/local/cuda-9.0/lib64/stubs
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-9.0/lib64
    ;;
*)
    # Do nothing
    ;;
esac

# Homeshick
## As a reminder, here is how you commit changes to dotfiles
## git cd dotfiles
## git commit -a -m "Comment here"
## git push origin master
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

