# Setup root
. ~/ROOT/bin/thisroot.sh
#alias root="root -l"

# Current working directory
WORK="/Users/hannahpullen/pplx/analysis/monte_carlo/reco_efficiency"

# Autojump
#[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh

# Disable tab autocomplete hidden files
bind 'set match-hidden-files off'

# General aliases
alias la="ls -a"
alias ll="ls -GFlash"
alias lt="ls -l -t"
alias c="clear"
alias cls="clear && ls"
alias cd..="cd .."
alias ..="cd .."
alias male="make"
alias mae="make"
alias makefile="vim makefile"
alias beep="tput bel"

# Move deleted files to trash
alias trash="rmtrash"
alias del="rmtrash"

# Useful aliases for bash/vim
alias vimrc="vim ~/.vimrc"
alias bashp="vim ~/.bash_profile"
alias sourceb="source ~/.bash_profile"

# ssh aliases
alias pplx="ssh -XY pullen@pplxint8.physics.ox.ac.uk"
alias lxplus="ssh -XY hpullen@lxplus.cern.ch"

# Vim aliases 
# Use macvim
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
# Shortcuts to open all C++ files in a project
alias hpp='vim inc/*.hpp'
alias cpp='vim src/*.cpp'

# Use emacs in bash
set -o emacs
stty werase undef
bind '"\C-w":kill-whole-line'

# Alias for git push
alias push="git push -u origin master"

# Increase size of command history
HISTSIZE=1000

# General functions
# Change directory and print contents
function cdl { cd "$@" && clear && ls; }
alias cd="cdl"
# Move contents of dir into a new subdir
function mvToDir {
    DIRNAME="$1"
    mkdir ../$DIRNAME
    mv * ../$DIRNAME
    mv ../$DIRNAME .
}
# Delete all files in directory except one
function delAllExcept {
    FILENAME="$1"
    mv $FILENAME ..
    del *
    mv ../$FILENAME .
}
# Restore deleted files
function restore { 
    FILENAME="$1"
    TRASHPATH="~/.Trash/$FILENAME"
    mv "$TRASHPATH" .
}
# Mark the location of a directory to return to later
function mark { export $1="`pwd`"; }
# Reload directory if it has broken (e.g. due to closed ssh connection)
function reloadDir { 
    cwd="`pwd`"
    cd 
    cd $cwd
    clear && ls
}
# Copy contents of a directory to another directory
function copyContents {
    OLDDIR='$1'
    NEWDIR='$2'
    cp -r "$OLDDIR/*" $NEWDIR
}
alias cpc='copyContents'

# Remote directory mounting
function mount_pplx {
    if [ -d ~/pplx ]; then  
        echo "pplx already mounted"
    else
        mkdir ~/pplx
        sshfs -o idmap=user pullen@pplxint8.physics.ox.ac.uk:/home/pullen ~/pplx
    fi
}
function mount_lxplus {
    if [ -d ~/lxplus ]; then  
        echo "lxplus already mounted"
    else
        mkdir ~/lxplus
        sshfs -o idmap=user hpullen@lxplus.cern.ch:/afs/cern.ch/user/h/hpullen ~/lxplus 
    fi
}
function mount_gangadir {
    if [ -d ~/gangadir ]; then  
        echo "gangadir already mounted"
    else
        mkdir ~/gangadir
        sshfs -o idmap=user pullen@pplxint9.physics.ox.ac.uk:/data/lhcb/users/pullen/gangadir ~/gangadir      
    fi
}
function unmount_all {
    if [ -d ~/pplx ]; then  
        umount -f ~/pplx
        rmdir ~/pplx
        echo "pplx unmounted"
    else
        echo "pplx not currently mounted"
    fi
    if [ -d ~/lxplus ]; then
        umount -f ~/lxplus
        rmdir ~/lxplus
        echo "lxplus unmounted"
    else    
        echo "lxplus not currently mounted"
    fi
    if [ -d ~/gangadir ]; then
        umount -f ~/gangadir
        rmdir ~/gangadir
        echo "gangadir unmounted"
    else    
        echo "gangadir not currently mounted"
    fi
}
alias mp="mount_pplx && reloadDir"
alias mg="mount_gangadir && reloadDir"

# Exiting aliases
alias exit="unmount_all && exit"
alias e="unmount_all && exit"

# tmux related aliases and functions
alias ks="tmux kill-session"
alias kp="tmux kill-pane"
alias kw="tmux kill-window"
alias td="tmux detach"
# Split tmux into three panes for coding
function tmux_coding {
    tmux split-window -h\;
    tmux split-window -v -p 20
}
# Get rid of all panes except the first
function tmux_normal {
    tmux kill-pane -a -t 0
}
# If in tmux, detach rather than exit
function exit {
    if [[ -z $TMUX ]]; then
        builtin exit
    else
        tmux detach
    fi
}

# Colour coding in ls
alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Powerline 
if [ -d "$HOME/Library/Python/2.7/bin" ]; then
    PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi
. /Users/hannahpullen/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

# Mount pplx if not yet mounted
#if ! [ -d ~/pplx ]; then  
#    mount_pplx
#fi

# Other random crap
#export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

## MacPorts Installer addition on 2016-11-30_at_15:55:31: adding an appropriate PATH variable for use with MacPorts.
#export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
#export MANPATH=/opt/local/share/man:$MANPATH

## Terminal colours
#NM="[\033[0;38m]" #means no background and white lines
#HI="[\033[0;37m]" #change this for letter colors
#HII="[\033[0;31m]" #change this for letter colors
#SI="[\033[0;33m]" #this is for the current directory
#IN="[\033[0m]"

#export PS1="$NM[ $HI\u $HII\h $SI\w$NM ] $IN"

#if [ "$TERM" != "dumb" ]; then
    #export LS_OPTIONS=‘–color=auto’
    #eval gdircolors ~/.dir_colors
#fi

## coreutils aliases
#alias ls="ls $LS_OPTIONS -hF"
#alias ll="ls $LS_OPTIONS -lhF"

#function _update_ps1() {
#    PS1="$(~/powerline-shell.py $? 2> /dev/null)"
#}

#if [ "$TERM" != "linux" ]; then
   # PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi
