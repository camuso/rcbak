# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

shopt -s extglob

#export CLICOLOR=1
#export LSCOLORS=DxGxcxdxCxegedabagacad

# from http://wiki.bash-hackers.org/scripting/debuggingtips
#
# export PS4='+(${BASH_SOURCE}:${LINENO}): '

# Prarit's semi-useless tools
# git clone git://git.engineering.redhat.com/users/prarit/tools

# Prarit's RHKL git repo tools
# git clone https://gitlab.cee.redhat.com/prarit/public-inbox-tools

echo $PATH | grep $HOME > /dev/null
[ $? -eq 0 ] || export PATH=$PATH:$HOME/bin:$HOME/public-inbox-tools/

export TEMPDIR=~/Maildir/temp/
export PRJDIR=../foo
export HISTCONTROL=ignoredups
export EDITOR=vim

#echo $LS_COLORS > old_colors
unset LS_COLORS && declare LS_COLORS='no=00:fi=00:di=01;93:ln=00;36:pi=40;33:so=01;95:bd=40;33;01:cd=40;33;01:tw=01;04;33:ow=01;04;35:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;95:*.jpeg=01;95:*.gif=01;95:*.bmp=01;95:*.pbm=01;95:*.pgm=01;95:*.ppm=01;95:*.tga=01;95:*.xbm=01;95:*.xpm=01;95:*.tif=01;95:*.tiff=01;95:*.png=01;95:*.mng=01;95:*.pcx=01;95:*.mov=01;95:*.mpg=01;95:*.mpeg=01;95:*.m2v=01;95:*.mkv=01;95:*.ogm=01;95:*.mp4=01;95:*.m4v=01;95:*.mp4v=01;95:*.vob=01;95:*.qt=01;95:*.nuv=01;95:*.wmv=01;95:*.asf=01;95:*.rm=01;95:*.rmvb=01;95:*.flc=01;95:*.avi=01;95:*.fli=01;95:*.gl=01;95:*.dl=01;95:*.xcf=01;95:*.xwd=01;95:*.yuv=01;95:*.svg=01;95:'
export LS_COLORS

# export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=01;32:ln=01;32:bn=32:se=36'
export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=95:ln=32:bn=32:se=36'

#
# Text Attributes
#
unset BLD && declare BLD="\[\033[1m\]"
unset UND && declare UND="\[\033[4m\]"
unset OFF && declare OFF="\[\033[0m\]"
#
# Text color definitions
#
unset BLK && declare BLK='\[\e[0;30m\]'
unset RED && declare RED='\[\e[0;31m\]'
unset GRN && declare GRN='\[\e[0;32m\]'
unset YEL && declare YEL='\[\e[0;33m\]'
unset BLU && declare BLU='\[\e[0;34m\]'
unset MGT && declare MGT='\[\e[0;35m\]'
unset CYN && declare CYN='\[\e[0;36m\]'
unset WHT && declare WHT='\[\e[0;37m\]'
#
# Bright colors
#
unset BBLK && declare BBLK='\[\e[1;90m\]'
unset BRED && declare BRED='\[\e[1;91m\]'
unset BGRN && declare BGRN='\[\e[1;92m\]'
unset BYEL && declare BYEL='\[\e[1;93m\]'
unset BBLU && declare BBLU='\[\e[1;94m\]'
unset BMGT && declare BMGT='\[\e[1;95m\]'
unset BCYN && declare BCYN='\[\e[1;96m\]'
unset BWHT && declare BWHT='\[\e[1;97m\]'

if [ $(id -u) -eq 0 ]; then # you are root, set root prompt
	export PS1="[$BRED\u$BRED@$BGRN\h $BYEL\W$OFF]$BRED# $OFF"
else # normal user
	export PS1="[$BMGT\u$BRED@$BGRN\h $BYEL\W$OFF]$BMGT$ $OFF"
fi

# User specific aliases and functions
#
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -iv'

function today {
	echo "Today's date is:"
	date +"%A, %B %-d, %Y"
}
alias alf='ls -alFch'
# alias lsd='ls -ald  */ .*/'
alias searchdown='perl /usr/bin/searchdown.pl'
alias mntiso='mount -o loop -t iso9660'
alias gitampatch='rlwrap gitampatch'
alias rold='pushd +1'
alias rord='pushd -1'
alias vboxmanage='/usr/lib/virtualbox/VBoxManage'
alias rsyncp='rsync -Pvat -e "ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null'"'
alias grep="grep --color"

# Need to get the grep version, because earlier versions do not support
# the '-T' option.
#
# The minimum version supporting the '-T' option is 2.6.0
#
mingrepversion=260

# Get the first line of the grep version and trim out everything but the
# version number.
#
grepversion=$(grep -V | head -1 | tr -cd '[[:digit:]]')

# If the grepversion is 2.6.0 or greater, then it supports '-T', initial tabs
#
if [ $grepversion -ge $mingrepversion ]; then tabs='T'; else tabs=''; fi

alias grap="grep --color -Hn$tabs"

# grep ignoring case (i), ignoring binaries (I), print filenames (H),
# and skip other file systems.
#
alias grip='grep -iIHr -D skip --color'

# ssh with no key checking and no known_hosts file
#
alias ssh="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

[ -e /usr/bin/vimx ] && alias vim='/usr/bin/vimx'

# No ttyctl, so we need to save and then restore terminal settings
vim(){
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}
typeset -fx vim

vimdiff(){
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vimdiff "$@"
    stty "$STTYOPTS"
}
typeset -fx vimdif

lsd(){
    [ "$1" ] && cd $1;
    ls --color=auto -ald */ .*/;
    [ "$1" ] && cd -
}

# Also ... find . ! -name . -prune -type f
lsf(){
	[ "$1" ] && cd $1;
	ls -alFch | grep --color ^[^d];
	[ "$1" ] && cd -;
}

myos() {
	cat /etc/*release | grep -w PLATFORM_ID | cut -d':' -f2 | cut -d'"' -f1
}

# comment2commits source-dir dest-file
#
# Parses the patchfiles in source-dir for commit numbers and writes them
# to dest-file as a 40-char hash followed a number/total for each commit
# in the patch series.
#
# $1 - directory in which the *.patch files are kept
# $2 - the file into which the commits will be written
#
comment2commits(){
	echo "comment2commits source-dir:$1  dest-file: $2"
	[ $# -eq 2 ] || exit 1
	source ~/bin/lib/ui.source;
	source ~/bin/lib/gitutilities.source;
	git_comment2commitsfile "$1" "$2";
}

# comment2list source-dir
#
# Parses the patchfiles in source dir for commit numbers and writes them
# to stdout in 'git log --oneline' format.
#
comment2list(){
	local templist=/dev/shm/templist
	echo "comment2commits patch-directory"
	[ $# -eq 1 ] || exit 1

	comment2commits "$1" $templist 2>&1>/dev/null
	while read line; do
		git log --oneline -n1 $(echo $line | cut -d' ' -f1)
	done < $templist
	rm -f $templist
}

# strtok - tokenizes a string and returns an array
#
# $1 - the string to tokenize
# $2 - the string of delimiters
# $3 - returns the tokenized string as an array
#
# examples:
#
# strtok kernel-pegas-4.11.0-2.el7.x86_64 ".-" array
#
# ${array[@]} will contain all the tokens separated by delimiters "."
# and "-", and the delimiters will be replaced by spaces.
#
strtok() {
	IFS="$2" read -r -a $3 <<< "$1"
}

# git backporting helps
up() { extup -1 $1; }
upme() { extup -r $(gitlasttag)..HEAD; }
gitfilhis() { gitnice -r -c "$1" "$2"; }
showme() { git show $2 | grep --color -n "$1"; }
myremotes() { git remote -v | grep tcamuso; git branch -r | grep tcamuso; }
gremote() { git branch -r | grep $1; }
# export DISPLAY=localhost:0.0
export HISTTIMEFORMAT="%Y/%m/%d %T "
export WORK="/WORK"

source $HOME/bin/chrepo
alias cr='chrepo'
