if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -d /opt/homebrew/bin
    eval (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.profile
end

if type -q "eza"
	alias ls="eza"
end

if type -q "fnm"
	fnm env | source
end

alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias vi="nvim"
alias vim="nvim"

# DNS Flushing section
switch (uname)
	case Linux
		alias flushdns="sudo resolvectl flush-caches"
	case Darwin
		alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
end

export DENO_INSTALL="/home/evanrh/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
