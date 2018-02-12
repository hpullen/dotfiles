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
        sshfs -o idmap=user pullen@pplxint9.physics.ox.ac.uk:/data/lhcb/users/pullen/ ~/gangadir
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
