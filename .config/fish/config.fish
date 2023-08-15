if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias vi="nvim"
alias vim="nvim"

export DENO_INSTALL="/home/evanrh/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
