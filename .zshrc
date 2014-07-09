# Set up the prompt

git_branch () {
	gitdir='.git'
	branch=''
	if [ -d "$gitdir" ]; then
		branch=$(git branch | grep -e '^\*')
		echo "$branch"
	fi
}

#PS1="$PS1 `git_branch`> "

autoload -Uz promptinit vcs_info
promptinit
prompt walters
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%{$reset_color%} [%{$fg[blue]%}%b]%{$reset_color%}"
###zstyle ':vcs_info:git*' formats "%b"

precmd () { vcs_info }
setopt prompt_subst
PS1="$PS1\$vcs_info_msg_0_> "
###PS1="$PS1%{$reset_color%}%{$fg[blue]%}\$vcs_info_msg_0_%{$reset_color%}> "

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ssh completion
[ -f ~/.ssh/known_hosts ] && : ${(A)ssh_known_hosts:=${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*}}
zstyle ':completion:*:*:*' hosts $ssh_known_hosts

# Alias
alias cdaf='cd /home/roger/Repo/adsp-front'
