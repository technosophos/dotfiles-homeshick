# ZSH Theme
# Based on gnzh, bira theme

# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

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

local return_code="%(?..%{$PR_RED%}%? ↵%{$PR_NO_COLOR%})"

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
PROMPT="${start_p} ${user_host} ${current_dir} ${gvp_go} ${git_branch}  ${in_vimode} $VIM_MODE
⇒ $PR_PROMPT "
RPS1="${return_code}"
#RPS2='$(vi_mode_prompt_info)'

# Right prompt: Show vi mode.
#RPROMPT='$(vi_mode_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$PR_YELLOW%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$PR_NO_COLOR%}"
