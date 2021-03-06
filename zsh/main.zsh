export DISABLE_AUTO_TITLE=true
export EDITOR='/usr/local/bin/nvim'
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LESS='-i -M -R -z-4'
export VISUAL='/usr/local/bin/nvim'
export GREP_COLOR="30;43"

# ZSH options
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt HISTIGNORESPACE           # Don't save commands with leading space to history
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt NO_CORRECT                # Turn off autocorrect
setopt NO_INC_APPEND_HISTORY     # Write to the history file only when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

# Z settings
Z_SCRIPT="$HOME/.config/z/z.sh"
[[ -s $Z_SCRIPT ]] && source $Z_SCRIPT

# FZF settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf-utils.zsh ] && source ~/.fzf-utils.zsh

export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export FZF_DEFAULT_OPTS='--color=dark,bg+:18 --bind=ctrl-z:toggle-up --inline-info --height 50% --no-reverse --border --bind=alt-a:select-all+accept'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--no-reverse'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-eighties.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# virtualenv-wrapper
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
VIRTUALENVWRAPPER="/usr/local/bin/virtualenvwrapper.sh"
[[ -s $VIRTUALENVWRAPPER ]] && source $VIRTUALENVWRAPPER

# Activate virtualenv in a child shell
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# Set TERM variable correctly in and out of tmux
[[ $TMUX = "" ]] && export TERM="xterm-256color" || TERM="screen-256color"

# Dir for my scripts
[[ -d $HOME/bin ]] && PATH=$HOME/bin:$PATH

# Brew sbin dir
export PATH="/usr/local/sbin:$PATH"

# Try to fix disappering cursor in gnome-terminal
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Edit long commands with vim
autoload edit-command-line
zle -N edit-command-line
bindkey '^g^g' edit-command-line

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit

# Aliases
# ================================================
alias ll='ls -l -A -G -h'
alias l='ls -l -A -G -h'
alias r=ranger
alias ag='ag --mmap'
alias grep='ag --mmap'

# Aliases for Linux setups
if [[ $(uname -s) = Linux ]]; then
    alias pbcopy='xclip -sel clip'
    alias pbpaste='xclip -sel clip -o'
fi

# Git
alias gd='git diff -w'
alias gdc='git diff --cached -w'
alias gp='git push origin HEAD'
alias gs='git status -sb'

alias rm=trash

# Vim aliases
alias e="nvim"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

# Tmux aliases
alias tl="tmux ls | cut -d ' ' -f 1 | sed 's/://'"
alias tat="tmux attach -t"
alias ta="tmux attach"
alias td="tmux detach"

alias dotfiles="ls -a | grep '^\.' | grep --invert-match '\.DS_Store\|\.$'"

# Utils
# ================================================
# Easily create sessions or switch to existing sessions
function _check_session() {
    tmux ls | grep $1
}
function tmuxx() {
    [[ $TMUX == "" ]] && tmux new-session -As $1 || tmux switch-client -t $1
}
# Pipe http output to less for better browsing
function httpless {
    http --pretty=all --print=hb "$@" | less -R;
}

# Pyenv settings: should be at the end of the script
# cause pyenv modified PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
