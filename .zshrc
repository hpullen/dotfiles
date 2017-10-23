# Save current directory
CWD="`pwd`"

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

# Change colours for dir
POWERLEVEL9K_DIR_HOME_BACKGROUND="none"
POWERLEVEL9K_DIR_HOME_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="none"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="none"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="blue"

# Colours for OS icon
POWERLEVEL9K_OS_ICON_BACKGROUND="none"
POWERLEVEL9K_OS_ICON_FOREGROUND="default"

# Colours for status of command
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='none'
POWERLEVEL9K_FAIL_ICON=''

# Battery symbols and colours
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_ICON=''
POWERLEVEL9K_BATTERY_VERBOSE=false
# To do: change background colour of battery to 'none'
# POWERLEVEL9K_BATTERY_ICON=' '

# Segment separators
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='%F{default}  '
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%F{default}|'
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%F{default}Fa|'

# Git colours
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='none'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='none'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='none'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'

# Time format
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M}"
POWERLEVEL9K_TIME_FOREGROUND="default"
POWERLEVEL9K_TIME_BACKGROUND="none"

# Left prompt: os icon, current directory, git info
# Depends on whether pplx is mounted
if [ -d ~/pplx ] ; then
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
else
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
fi

# Right prompt: return status of last command, battery level, time
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs tmux battery time)    

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="false"

# History time stamp format
HIST_STAMPS="dd/mm/yyyy"

# Don't store commands starting with space in history
setopt HIST_IGNORE_SPACE

# Plugins to load
plugins=(common-aliases git fancy-ctrl-z osx extract python pip fast-syntax-highlighting solarized-man)

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
alias zr="source ~/.zshrc"
alias vimrc="/Applications/MacVim.app/Contents/MacOS/Vim ~/.vimrc"
alias c="clear"
alias del="rmtrash"
alias dirs="dirs -v"
alias cdirs="builtin dirs -c"
alias grep="grep -i -I --color" # Case insensitive colored grep

# Aliases with space (don't store in history)
# Use GNU ls for colors
alias ls=" gls --color=auto"
alias la=" gls -a --color=auto"
alias ll=" gls -lh --color=auto"
alias cls=" clear && gls --color=auto"
alias cd=" cd"
alias sed=gsed # Use GNU sed

# Use colordiff instead of diff
alias diff=colordiff

# Look at weather
alias weather="curl wttr.in"

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

# Load zcalc (command line calculator)
autoload -Uz zcalc

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

# Tmux aliases
alias ks="tmux kill-session"
alias kp="tmux kill-pane"
alias kw="tmux kill-window"
alias td="tmux detach"

alias songname="spotify status | /usr/bin/grep Track && spotify status | /usr/bin/grep Artist || echo 'No song is playing!'"

# Source custom functions
for file in ~/.custom_functions/*.sh; do
    source $file
done
source ~/.custom_functions/*.sh

# Custom function aliases
alias cpc='copyContents'
alias mp="mount_pplx && reloadDir"
alias mg="mount_gangadir && reloadDir"

# Load fasd
eval "$(fasd --init auto)"

# cd to previous working directory
cd $CWD
clear

# Start ssh agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent`
    ssh-add
fi
