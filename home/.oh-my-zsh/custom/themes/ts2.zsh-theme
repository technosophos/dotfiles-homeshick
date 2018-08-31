# ZSH Theme
# Based on gnzh, bira theme

# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

FAIL="\uf00d"

# make some aliases for the colours: (could use normal escape sequences too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$fg[${(L)color}]%}'
done
eval PR_NO_COLOR="%{$terminfo[sgr0]%}"
eval PR_BOLD="%{$terminfo[bold]%}"

# Check the UID
if [[ $UID -ge 1000 ]]; then # normal user
  eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
  eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
  local PR_PROMPT='$PR_NO_COLOR➤ $PR_NO_COLOR'
elif [[ $UID -eq 0 ]]; then # root
  eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
  eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
  local PR_PROMPT='$PR_RED➤ $PR_NO_COLOR'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
else
  eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
fi

local return_code="%(?..%{$PR_RED%}%? $FAIL%{$PR_NO_COLOR%})"

local user_host='${PR_USER}${PR_CYAN}@${PR_HOST}'
local current_dir='%{$PR_BOLD$PR_BLUE%}%~%{$PR_NO_COLOR%}'

#local gvp_go=$([ '' == $GOPATH ] || basename ${GOPATH##*:})
local gvp_go='%{$PR_CYAN%}$([[ -n $ALREADY_GLIDING  ]] || echo "%{$PR_RED%}")«$(dirname ${GOPATH##*:})»%{$PR_NO_COLOR%}'

local rvm_ruby=''
if ${HOME}/.rvm/bin/rvm-prompt &> /dev/null; then # detect local user rvm installation
  rvm_ruby='%{$PR_RED%}‹$(${HOME}/.rvm/bin/rvm-prompt i v g s)›%{$PR_NO_COLOR%}'
elif which rvm-prompt &> /dev/null; then # detect sysem-wide rvm installation
  rvm_ruby='%{$PR_RED%}‹$(rvm-prompt i v g s)›%{$PR_NO_COLOR%}'
elif which rbenv &> /dev/null; then # detect Simple Ruby Version management
  rvm_ruby='%{$PR_RED%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$PR_NO_COLOR%}'
fi
local git_branch='$(git_prompt_info)%{$PR_NO_COLOR%}'

# Support for Glide.
local start_p="☃"
if [[ -n $ALREADY_GLIDING ]]; then
  start_p="%{$PR_YELLOW%}🐝 %{$PR_NO_COLLOR%}"
fi

local in_vimode='$(vi_mode_prompt_info)'
#local in_vimode="${VIM_MODE}" #'$(vi_mode_prompt_info)'
#local in_vimode='$(vimode_type)'

#PROMPT="${user_host} ${current_dir} ${rvm_ruby} ${git_branch}$PR_PROMPT "
MODE_INDICATOR="💭"
OLD_PROMPT="${start_p} ${user_host} ${current_dir} ${gvp_go} ${git_branch}  ${in_vimode} $VIM_MODE
⇒ $PR_PROMPT "

# Print the error on the right
#RPS1="${return_code}"

# Print VI mode info on the right
#RPS2='$(vi_mode_prompt_info)'

#RPS1="${PR_CYAN}$(print -n "\ue725")${PR_NO_COLOR} ${git_branch}"

RPS1="${PR_MAGENTA}$(print -n "\ue0cd") ${user_host}${PR_NO_COLOR}"

house="\uf015"
i_folder="\uf07c"
i_employer="\uf17a"
i_plane="\uf1d9"
i_sombra="\ue0cd"
i_sombra2="\ue0cc"
i_git="\uf1d3"
i_fork="\ue725"

abbrev_pwd() {
  ghre="s|github\.com|\\\uf408 |"
  # gre="s|${GOPATH}|\\\ue724 |" #line-gopher
  gre="s|${GOPATH}|\\\ue626 |" # running gopher
  codere="s|${CODE}|\\\uf490 |"
  re="s|${HOME}|\\\uf015 |"
  pwd | sed $ghre | sed $gre | sed $codere| sed $re
}

prompt_return_code() {
  [[ $RETVAL -ne 0 ]] && print -n " $PR_RED$FAIL $RETVAL$PR_NO_COLOR\n"
}

main_prompt() {
  RETVAL=$?
  prompt_return_code
  prompt_status_start
  prompt_status
  prompt_sep
  prompt_git
  prompt_sep
  prompt_kube
  prompt_status_end
  prompt_prompt
  #print -n "\uf0b5 \ue0c4\n$ "
}

prompt_sep() {
  print -n " ${PR_MAGENTA}|${PR_NO_COLOR} "
}

prompt_git() {
  local git_branch=$(git_prompt_info)
  print -n "${PR_YELLOW}${i_git}${PR_NO_COLOR}${git_branch}"
}

prompt_kube() {
  ctx=$(kubectl config current-context)
  print -n "${PR_BLUE}\uf0ee ${ctx}${PR_NO_COLOR}"
}

prompt_status_start() {
  #print -n " ${PR_YELLOW}${i_folder}${PR_BLUE} "
  print -n "${PR_MAGENTA}${i_sombra}${PR_NO_COLOR} "
}
prompt_status(){
  print -n " ${PR_MAGENTA}$(abbrev_pwd)${PR_NO_COLOR}"
}
prompt_status_end() {
  print -n "${PR_NO_COLOR}"
}

prompt_prompt() {
  print -n "\n${PR_MAGENTA}${i_sombra2}${PR_NO_COLOR} "
}

PROMPT='$(main_prompt)'

# Right prompt: Show vi mode.
#RPROMPT='$(vi_mode_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$PR_YELLOW \ue725 %}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$PR_NO_COLOR%}"
