echo "Welcome to zsh!"
echo "Customized by"
echo "     __  __  _____"
echo "    / /_/ / / ___ \\"
echo "   /   __/ / /__/ /"
echo "  / /\ \  / _____/"
echo " /_/  \_\/_/"

export CLICOLOR=1
export TERM=xterm-256color
export PATH=":/usr/local/sbin:$PATH"
source ~/.enhancd/enhancd.sh

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

PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%(?.%{${fg[blue]}%}.%{${fg[red]}%})\$%{${reset_color}%} "

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

function s(){
    if [ $# -eq 0 ]; then
        cat > /tmp/tmux.tmp && tmux split-window "less /tmp/tmux.tmp"
    else
        REATTACH_TO_USER_NAMESPACE=`whence reattach-to-user-namespace`
        tmux split-window "$REATTACH_TO_USER_NAMESPACE $*"
    fi
}
function v(){
    if [ $# -eq 0 ]; then
        cat > /tmp/tmux.tmp && tmux split-window -h "less /tmp/tmux.tmp"
    else
        REATTACH_TO_USER_NAMESPACE=`whence reattach-to-user-namespace`
        tmux split-window -h "$REATTACH_TO_USER_NAMESPACE $*"
    fi
}
########################################
#------------- エイリアス -------------#
########################################

alias sshot=$ANDROID_SDK"/tools/screenshot2 ~/Desktop/screenshot.png; open ~/Desktop/screenshot.png";
alias uninstallapp='adbp shell pm list package | sed -e s/package:// | peco | xargs adbp uninstall'
alias ls='ls -G -F'
alias la='ls -a'

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

########################################

if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session && exit
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | peco | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session && exit
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID" && exit
  else
    :  # Start terminal normally
  fi
fi

