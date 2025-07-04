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

if type -q "bat"
  alias cat="bat"
end

function tmux_preview
  tmux list-windows -t $argv[1] -F '#I: #W (#{window_panes} panes)'
  printf "\n\n"
  tmux capturep -t $argv[1]:1 -p
end

function __tmux_session_names
  tmux list-sessions -F "#S" 2>/dev/null | string split "\n"
end
# Function to fuzzy find and select a tmux session to open
function open_tmux_session
  #set session $(tmux list-sessions -F "#S" | fzf --preview "tmux list-windows -t {} -F '#I: #W (#{window_panes} panes)'")
  set sessions $(__tmux_session_names)
  set numSessions (count $sessions)

  if test (count $argv) -eq 1
    set session $argv[1]
  else if test $numSessions -eq 0
    echo "No sessions available"
    return 1
  else if test $numSessions -eq 1
    set session $sessions
  else
    set session $(__tmux_session_names | fzf --preview "tmux_preview {}")
  end

  if test -n "$session"
    tmux attach -t "$session"
  end
end

complete -c open_tmux_session -f -n "__fish_use_subcommand " -a "(__tmux_session_names)"

# Common aliases for command subs that I use
alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias lazyconfig="lazygit --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias vi="nvim"
alias vim="nvim"
alias clearteams="rm -rf $HOME/Library/Group Containers/UBF8T346G9.com.microsoft.teams && rm -rf $HOME/Library/Containers/com.microsoft.teams2/Data"
alias lg="lazygit"
alias refresh=". ~/.config/fish/config.fish"
alias opensession=open_tmux_session
alias os=opensession

# Common aliases based off of host system
# Setup common remaps too
switch (uname)
  case Linux
    alias flushdns="sudo resolvectl flush-caches"
  case Darwin
    alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
    alias listening="sudo lsof -iTCP -sTCP:LISTEN -n -P"
    alias bfupdate="brew bundle --file ~/.config/homebrew/Brewfile"
    alias realpath="grealpath"
end

export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export DENO_INSTALL="/home/evanrh/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

if type -q "zoxide"
  zoxide init fish | source
  alias cd="z"
end
