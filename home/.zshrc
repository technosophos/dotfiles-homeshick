# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

autoload -U zmv

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME=${ZSH_THEME:="ts2"}

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git jump docker docker-machine)

# User configuration
# Base16 Shell
BASE16_THEME="base16-monokai"
BASE16_SHELL="$HOME/.config/base16-shell/scripts/$BASE16_THEME.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Glide support.
if [[ "" = "${GOPATH}" ]]; then
  export GOPATH=$HOME/Code/Go
fi
export CODE=$HOME/Code
export GOGH=$GOPATH/src/github.com

export PATH="$GOPATH/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export GO15VENDOREXPERIMENT=1
# export MANPATH="/usr/local/man:$MANPATH"

# Rust support
if [[ -e $HOME/.cargo/bin ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
  export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
fi

hs_bin="$HOME/.homesick/repos/homeshick/homeshick.sh"
if [[ -e "$hs_bin" ]]; then
  source $hs_bin
fi
source $ZSH/oh-my-zsh.sh

# DEIS
export DEIS=$HOME/Code/Go/src/github.com/deis
export AZURE=$HOME/Code/Go/src/github.com/Azure
export HELM=$HOME/Code/Go/src/k8s.io/helm
export HELM_HOME=$HOME/hh

# Brigade
export BRIG=$AZURE/brigade

# Kubernets k8s
export KUBE=$GOPATH/src/github.com/kubernetes/kubernetes

# Kube-Solo support
# export KUBECONFIG=/Users/mattbutcher/kube-solo/kube/kubeconfig:/Users/mattbutcher/.kube/config

export KUBECONFIG=$HOME/.kube/config

# Docker Machine (is lame)
#eval $(docker-machine env helm)
#export DEV_REGISTRY=$(docker-machine ip helm)

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Use mvim
export EDITOR='mvim'

# For ghi
export GITHUB_USER='technosophos'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias k="kubectl"
alias kj="kubectl -o json"
alias ky="kubectl -o yaml"

alias kk="kubectl -n kube-system"

alias kh="kubectl --namespace=helm"
alias khy="kubectl --namespace=helm -o yaml"

alias kgp="kubectl get pod"

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias hgrep="fc -El 100 | grep"

alias nvimedit='nvim $HOME/.config/nvim'

# Homeschick
alias hscd='homeshick cd dotfiles-homeshick'
alias hstrack='homeshick track dotfiles'

# Helm
alias h=helm

# Git
alias g=git

# Brigade
alias brig="$BRIG/bin/brig"

# Reset the ll alias to my command
alias ll='$GOPATH/bin/ll'

alias zoombie='sudo killall VDCAssistant'

alias netstatl='netstat -an | grep LISTEN'

# kubectl shortcuts
alias um='kubectl config use-context minikube && eval $(minikube docker-env)'
alias use-mk='kubectl config use-context minikube && eval $(minikube docker-env)'
alias use-bci='kubectl config use-context brigade-ci'
alias use-dfm='kubectl config use docker-for-desktop'

alias ot='osascript $CODE/firefox-open-tab.applescript'

# GLOBAL aliases

alias -g GW='-l role=gateway'

# Simple function to open the current working directory in nvim.
function vdir {
  ${EDITOR} ${PWD}
}

# lodoc opens godocs for local dependencies based on what is in vendor/
function lodoc {
  pkg=$1
  symbol=$2
  dir=$(git worktree list | awk '{ print $1 }')
  godoc $dir/vendor/$pkg $symbol | mvim -R -c 'color base16-mocha' -
}

function coodoc {
  godoc github.com/Masterminds/cookoo/$1 $2
}

function helmdoc {
  godoc k8s.io/helm/$1 $2
}

function helm-out {
  cd $HELM
  scripts/local-cluster.sh stop
  cd -
  docker-machine stop helm
}

function helm-in {
  docker-machine start helm
  cd $HELM
  scripts/local-cluster restart
  cd -
  eval $(docker-machine env helm)
}

if [[ -e ~/.mpb_env ]]; then
  source ~/.mpb_env
fi

# Set the colorscheme.
function colorscheme {
  BASE16_SHELL="$HOME/.config/base16-shell/scripts/$1.sh"
  [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
}

# List all of the colorschemes
function colorschemes {
  ls $HOME/.config/base16-shell/scripts/ | awk '{sub(/\.sh/, "")}; 1'
}

# Cycle through all of the colorschemes
function showcolorschemes {
  for i in $(colorschemes); do
    colorscheme $i
    echo -n "\rThis is $i                                  "
    sleep 2
  done
  echo "Resetting"
  . $BASE16_SHELL
}


# Update PATH for new Helm
export PATH=$HELM/bin:$PATH

# Enable fuzzy finder
#_fzf_compgen_path() {
#  ag -g "" "$1"
#}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Docker Version Manager
[ -f /usr/local/opt/dvm/dvm.sh ] && . /usr/local/opt/dvm/dvm.sh
