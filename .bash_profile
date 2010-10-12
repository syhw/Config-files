#
# Your previous .profile  (if any) is saved as .profile.mpsaved
# Setting the path for MacPorts.
export PATH=/Users/gabrielsynnaeve/.cabal/bin:~/local/bin:/opt/local/bin:/opt/local/sbin:$PATH:/usr/local/ada-4.3/bin:/usr/sbin:/usr/local/bin
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

# Setting PATH for MacPython 2.5
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
#export PATH

##
# Your previous /Users/gabrielsynnaeve/.bash_profile file was backed up as /Users/gabrielsynnaeve/.bash_profile.macports-saved_2009-11-18_at_14:13:00
##

# MacPorts Installer addition on 2009-11-18_at_14:13:00: adding an appropriate PATH variable for use with MacPorts.
## export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

