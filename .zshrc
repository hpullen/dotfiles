# Export environment variabes
export TERM='xterm-256color'
export EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim'

# Use macvim instead of vim
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

# ROOT setup
cd ~/ROOT/bin/
source thisroot.sh
cd
alias root="root -l"

# Path to oh-my-zsh installation
export ZSH=/Users/hannahpullen/.oh-my-zsh

# Set theme
POWERLEVEL9K_MODE='awesome-fontconfig'
ZSH_THEME="powerlevel9k/powerlevel9k"

# PowerLevel9k settings
# Shorten dir and status
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
POWERLEVEL9K_STATUS_VERBOSE="FALSE"

# Colours for OS icon
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="black"

# Battery symbols and colours
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_ICON=' '

# Time format
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M}"

# Left prompt: os icon, current directory, git info
# Depends on whether pplx is mounted
if [ -d ~/pplx ] ; then
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
else
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
fi

# Right prompt: return status of last command, battery level, time
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status battery time)    

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="false"

# History time stamp format
HIST_STAMPS="dd/mm/yyyy"

# Don't store commands starting with space in history
setopt HIST_IGNORE_SPACE

# Plugins to load
plugins=(common-aliases brew git fancy-ctrl-z osx extract python pip zsh-syntax-highlighting)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Turn off some oh-my-zsh features whenever oh-my-zsh is loaded
function modify_omz {
    # Get rid of rm -i alias
    unalias rm
    # Stop sharing history between panes in tmux
    setopt nosharehistory
}
# Apply function on first load
modify_omz

# Directory colours
# For normal ls, solarized-like colorscheme
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
# For GNU ls use solarized dark colorscheme
eval `gdircolors /Users/hannahpullen/clone/dircolors-solarized/dircolors.ansi-dark`
# Use solarized in zsh tab completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Turn off autocorrection
unsetopt correct

# General aliases
alias zshrc="/Applications/MacVim.app/Contents/MacOS/Vim ~/.zshrc"
alias sourcez="source ~/.zshrc"
alias vimrc="/Applications/MacVim.app/Contents/MacOS/Vim ~/.vimrc"
alias c="clear"
alias del="rmtrash"

# Aliases with space (don't store in history)
# Use GNU ls for colors
alias ls=" gls --color=auto"
alias la=" gls -a --color=auto"
alias ll=" gls -l --color=auto"
alias cls=" clear && gls --color=auto"
alias cd=" cd"

# ssh aliases
alias pplx="ssh -Y pullen@pplxint8.physics.ox.ac.uk"
alias lxplus="ssh -Y hpullen@lxplus.cern.ch"

# Suffix aliases (automatically open these files in vim)
alias -s txt=$EDITOR
alias -s C=$EDITOR
alias -s cpp=$EDITOR
alias -s h=$EDITOR
alias -s hpp=$EDITOR
alias -s py=$EDITOR

# CDPATH: contains path to pplx analysis code
export CDPATH=/Users/hannahpullen/pplx/analysis/tuple_scripts/analysis_code/

# Load zmv. Use -n to show what will be done, without executing
autoload -U zmv

# General functions
# cd and cls
function cdl { cd "$@" && clear && ls; }

# Move contents of directory into a new subdirectory
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

# Restore deleted files from trash
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
    # Turn vcs on or off depending on mounting
    if [ -d ~/pplx ] ; then
        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
    else
        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
    fi
    source $ZSH/oh-my-zsh.sh
    modify_omz
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
    if [ -d ~/pplx ] ; then
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
        sshfs -o idmap=user hpullen@lxplus.cern.ch:/afs/cern.ch/work/h/hpullen ~/lxplus
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
    # Put back git status
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
    source $ZSH/oh-my-zsh.sh
    modify_omz
}

# Mounting aliases
alias mp="mount_pplx && reloadDir"
alias mg="mount_gangadir && reloadDir"

# tmux aliases 
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
