# Set path if required
export PATH=$HOME/bin:/usr/local/go/bin:/usr/local/bin:$PATH

# dircolors --print-database > dircolors.default
d=dircolors.default
test -r $d && eval "$(dircolors $d)"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias bashly='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'

## Set up the prompt - if you load Theme with zplugin as in this example, this will be overriden by the Theme. If you comment out the Theme in zplugins, this will be loaded.
autoload -Uz promptinit
promptinit
# see Zsh Prompt Theme below
# prompt -l to see available prompts
#prompt bart

# Use vi keybindings even if our EDITOR is set to vi
bindkey -e

setopt histignorealldups sharehistory
setopt PROMPT_SUBST

# Keep 5000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="%Y-%m-%d %T"

# Use modern completion system
autoload -Uz compinit
compinit

## zplug - manage plugins
#source /usr/share/zplug/init.zsh
#zplug "plugins/git", from:oh-my-zsh
##zplug "plugins/sudo", from:oh-my-zsh
##zplug "plugins/command-not-found", from:oh-my-zsh
##zplug "zsh-users/zsh-syntax-highlighting"
##zplug "zsh-users/zsh-autosuggestions"
##zplug "zsh-users/zsh-history-substring-search"
##zplug "zsh-users/zsh-completions"
##zplug "junegunn/fzf"
#zplug "themes/robbyrussell", from:oh-my-zsh, as:theme   # Theme
#
## zplug - install/load new plugins when zsh is started or reloaded
#if ! zplug check --verbose; then
#    printf "Install? [y/N]: "
#    if read -q; then
#        echo; zplug install
#    fi
#fi
#zplug load --verbose

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# vim mode
bindkey -v
export KEYTIMEOUT=1
bindkey '^r' history-incremental-search-backward

# ssh hostname completion
_hosts() {
    compadd $(cat ~/.ssh/config ~/.ssh/client_config | grep -i hostname | awk '{print $2}')
}

git_current_branch() {
    git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -z "$git_branch" ]]; then
        echo ""
    else
        echo "git:$git_branch"
    fi
}

#
# Kubernetes
#

if [ $commands[kubectl] ]; then
    source <(kubectl completion zsh)
fi

# k8s context
get_k8s_current_context() {
    context=$(kubectl config current-context)
    if [[ -z "$context" ]]; then
	echo ""
    else
        echo "k8s:$context"
    fi
}

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV)) "
  fi
}
#PS1='$(show_virtual_env)'$PS1

#
# prompt configuration
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
PROMPT='%F{yellow}$(show_virtual_env)%F{default}%~ %F{red}$(get_k8s_current_context)%F{blue}:: %F{green}~ $(git_current_branch)%f » '

# bug gnome-control-center
alias gnome-reset-cc="gsettings reset org.gnome.ControlCenter last-panel"

function terraform-resource-references {
    IFS=$'\n';
    for LINE in $(grep -r '^resource "' | sort -u); do
	RESOURCE=$(echo $LINE | awk '{print $2 "." $3}' | sed -e 's/"//g');
	grep -cr "$RESOURCE" | awk -v resource_name="$RESOURCE" -F':' 'BEGIN{total=0}{total=total+$2}END{print resource_name ":" total}';
    done
}

function kube-session {
    KUBECONFIG_TMP_PATH="$HOME/.kube/tmp"
    mkdir -p $KUBECONFIG_TMP_PATH
    chmod 700 $KUBECONFIG_TMP_PATH
    # create kubeconfig file for session
    KUBECONFIG_FILENAME=$KUBECONFIG_TMP_PATH/config.$(date +%s-%N)
    cp $HOME/.kube/config $KUBECONFIG_FILENAME
    export KUBECONFIG=$KUBECONFIG_FILENAME
    echo "kubeconfig file configured to '${KUBECONFIG_FILENAME}'!"
    chmod 600 $KUBECONFIG_TMP_PATH/*
    # clean tmp folder
    find $KUBECONFIG_TMP_PATH -type f -mtime +90 -name "config.*" -delete
}

function curltor {
    ss -lpten "( sport = :9150 )" | grep "tor" >/dev/null && curl --socks5 127.0.0.1:9150 "$@" || echo "tor is not running"
}

export SSH_AUTH_SOCK=$HOME/.ssh/ssh-auth-sock

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# hook direnv into my shell
eval "$(direnv hook zsh)"
