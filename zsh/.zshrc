#
# Zsh configuration file. Will be sourced when starting an interactive shell.
#

autoload -U compinit promptinit colors run-help
compinit
promptinit
colors


# http://zsh.sourceforge.net/Doc/Release/Options.html

setopt promptsubst	 # expansion & substitution in prompt.
setopt histignorespace	 # prefix cmd/alias by space to leave out of history.
setopt histreduceblanks	 # trim blanks.
setopt histignorealldups # remove all old duplicates.
setopt histverify	 # don't execute history expansions directly.
setopt sharehistory      # sync history w/ file.


HISTFILE=~/.config/zsh/.zhistory
HISTSIZE=10000
SAVEHIST=$HISTSIZE


export BROWSER="firefox"
export EDITOR="zile"
export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LANG=en_US.UTF-8
export LC_CTYPE=sv_SE.UTF-8
cdpath=($HOME/Desktop $HOME/nexus/x)


bindkey -e # e for Emacs
bindkey "^r" history-incremental-search-backward


PS1="%F{blue}%n@%m %F{green}%~$prompt_newline%F{magenta}>:%f "
PS2="> "
PS3="? "
RPROMPT="%(?..%F{red}%?%f"


fortune


unalias run-help 2> /dev/null
alias help=run-help
alias zshrl="source ~/.zshrc"
alias x="chmod u+x"
alias l="ls -lh" # -h for Human readable
alias stow="stow -vt ~"
