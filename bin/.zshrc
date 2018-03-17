echo "Welcome to Zsh!"
echo "This computer is"
figlet `hostname`

export CLICOLOR=1
export TERM=xterm-256color
export PATH="/usr/local/bin::/usr/local/sbin:/Users/mizucoffee/Library/Android/sdk/build-tools:/Users/mizucoffee/Library/Android/sdk/ndk-bundle:/Users/mizucoffee/Library/Android/sdk/platform-tools:/Users/mizucoffee/Library/Android/sdk/tools:$PATH"
export ANDROID_HOME="/Users/mizucoffee/Library/Android/sdk"
source ~/.enhancd/init.sh
export LC_CTYPE=ja_JP.UTF-8

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

########################################
#--------------- ロード ---------------#
########################################

autoload -Uz colors
autoload -Uz select-word-style
autoload -Uz compinit
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

colors
select-word-style default
compinit

precmd() { vcs_info }

########################################
#-------------- 補完とか --------------#
########################################

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

zstyle ':vcs_info:*' formats '[%F{green}%b%f]'
zstyle ':vcs_info:*' actionformats '[%F{green}%b%f(%F{red}%a%f)]'

PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~%(?.%{${fg[blue]}%}.%{${fg[red]}%})\$%{${reset_color}%} "

########################################
#---------------- 関数 ----------------#
########################################

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

function gip() {
    ~/Documents/GitPeco/GitPeco.sh
  }
alias 'gip'

########################################
#------------- エイリアス -------------#
########################################

alias sshHome="ssh ritsuki@192.168.50.50 -i ~/.ssh/id_rsa -p 2222"
alias ls='ls -G -F'
alias la='ls -al'
alias g='git add . ; git commit ; git push'

########################################
#------------- オプション -------------#
########################################

setopt print_eight_bit
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt extended_glob
setopt correct
setopt prompt_subst
setopt nonomatch

########################################

#if [[ ! -n $TMUX ]]; then
#  tmux list-sessions > /dev/null 2>&1
#  if [ $? = 0 ]; then
#    ID="`tmux list-sessions`\n"
#  else
#    ID=""
#  fi

#  create_new_session="Create New Session"
#  no_use_tmux="No Use Tmux"
#  ID="$ID${create_new_session}:\n${no_use_tmux}:"
#  ID="`echo $ID | peco | cut -d: -f1`"
#  if [[ "$ID" = "${create_new_session}" ]]; then
#    tmux new-session && exit
#  elif [[ "$ID" = "No Use Tmux" ]]; then
#    :
#  elif [[ -n "$ID" ]]; then
#    tmux attach-session -t "$ID" && exit
#  else
#    :
#  fi
#fi

[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

# added by travis gem
[ -f /Users/mizucoffee/.travis/travis.sh ] && source /Users/mizucoffee/.travis/travis.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/mizucoffee/.sdkman"
[[ -s "/Users/mizucoffee/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mizucoffee/.sdkman/bin/sdkman-init.sh"
export GOPATH=/Users/mizucoffee/.go
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="/usr/local/opt/opencv3/bin:$PATH"
