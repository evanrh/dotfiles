if [ -n "$DESKTOP_SESSION" ]; then
	eval $(gnome-keyring-daemon --start)
	export SSH_AUTH_SOCK
fi

export EDITOR=vim
export TERMINAL=alacritty
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
