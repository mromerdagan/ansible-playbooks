
if ! typeset -f __git_ps1 2> /dev/null > /dev/null; then
	# From http://www.jonmaddox.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
	# Let's define primitive version of __git_ps1()
	__git_ps1() {
		#git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
		local br=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
		if [ -n "$br" ]; then
			printf "$1" "$br"
		fi
	}
fi

ps1_prompt() {
	local ps1_exit=$?
	if [ $ps1_exit -eq 0 ]; then
		echo '\$'
	else
		echo 'echo -e "\[\033[1;31m\]"'\$'"\[\033[0m\]"'
	fi
}

# Variables affect __git_ps1() from bash-completion
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
unset GIT_PS1_SHOWUNTRACKEDFILES
GIT_PS1_SHOWUPSTREAM='auto'

function proml {
	local      NORMAL="\[\033[0m\]"
	local       BLACK="\[\033[1;30m\]"
	local         RED="\[\033[0;31m\]"
	local   LIGHT_RED="\[\033[1;31m\]"
	local       GREEN="\[\033[0;32m\]"
	local LIGHT_GREEN="\[\033[1;32m\]"
	local  LIGHT_BLUE="\[\033[0;34m\]"
	local        BLUE="\[\033[1;34m\]"
	local     MAGENTA="\[\033[1;35m\]"
	local  LIGHT_GRAY="\[\033[0;37m\]"
	local       WHITE="\[\033[1;37m\]"
	case $TERM in
	xterm*)
		TITLEBAR='\[\033]0;\u@\h:\w\007\]'
		;;
	*)
		TITLEBAR=""
		;;
	esac


PS1="${TITLEBAR}\
$MAGENTA${debian_chroot:+($debian_chroot)}$BLACK\u@\h$NORMAL:$BLUE\w$GREEN\$(__git_ps1 ' (%s)')\
$BLACK\$$NORMAL "
PS2='> '
PS4='+ '
}
# PS1='\[\033[01;35m${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

proml
