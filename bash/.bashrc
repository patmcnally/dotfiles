source ~/.bashrc.d/.git-completion.sh
source ~/.bashrc.d/.git-alias-completion.sh
source ~/.bashrc.d/.git-prompt.sh
source ~/.bashrc.d/.functions

export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH:$HOME/bin
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export TERM=xterm-color
export EDITOR='vim'

# Display
export DISPLAY=:0.0

# Aliases
alias ls="ls -G"

function color_my_prompt {
    # Define some colors for use to use
    local __gold='\033[1;38;5;136m'
    local __none='\033[0m'
    if [ -n "$PRODUCTION_PS1" ]; then
      local __machine_color='\033[48;5;52m'
    else
      local __machine_color='\033[48;5;17m'
    fi

    # Some exports that modify what __git_ps1 does
    export GIT_PS1_SHOWDIRTYSTATE="1"
    export GIT_PS1_SHOWUNTRACKEDFILES="1"
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_STATESEPARATOR=""

    # Show user@host only when we're remote, coloring it differently on mission-critical machines
    if [ -n "$SSH_CLIENT" ]; then
      # I want some machines flagged as red, namely production machines
      local __machine="\[$__machine_color\][\u@\h]\[$__none\]"
    fi

    # Finally put it all together
    local __base_prompt="$__machine\[$__gold\]\W\[$__none\]"
    local __git_prompt_fmt='\[\033[2m\](%s)\[\033[0m\]'
    # Using PROMPT_COMMAND keeps BASH informed of exactly how long our prompt string is, avoiding issues with CTRL-A, etc.
    export PROMPT_COMMAND="__git_ps1 \"$__base_prompt\" \"\\\$ \" \"$__git_prompt_fmt\""
}
color_my_prompt

# Setup FASD
eval "$(fasd --init auto)"
alias v='f -e vim' # quick opening files with vim
