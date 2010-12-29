#
# Your previous .profile  (if any) is saved as .profile.mpsaved
# Setting the path for MacPorts.
export PATH=/Users/gabrielsynnaeve/.cabal/bin:/Users/gabrielsynnaeve/.gem/ruby/1.8/bin:~/local/bin:/usr/local/bin:/usr/local/sbin::/opt/local/bin:/opt/local/sbin:$PATH:/usr/local/ada-4.3/bin:/usr/sbin
#export PATH=/usr/sbin:/usr/local/bin:~/local/bin:/opt/local/bin:/opt/local/sbin:$PATH:/usr/local/ada-4.3/bin BECAUSE OF CABAL
export DISPLAY=:0.0
export CPATH=/usr/X11R6/include:/opt/local/include
export LIBRARY_PATH=/usr/X11R6/lib:/opt/local/lib:/usr/lib
export SVN_EDITOR=vim
export USERWM=`which xmonad`
alias sshserv='ssh snippy@82.233.119.108'
alias sshhome='ssh -p 7777 snippy@82.233.119.108'
alias pingserv='ping 82.233.119.108'
alias sshimag='ssh synnaevg@ensisun.imag.fr'
alias scpresume="rsync --partial --progress --rsh=ssh"

source .profile
#source .bash_rc
function range () { 
    if [ $1 -ge $2 ]; then
        return
    fi
    a=$1
    b=$2
    while [ $a -le $b ]; do
        echo $a;
        a=$(($a+1));
    done
} 

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi
