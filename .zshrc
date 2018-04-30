clear
echo
#echo "Welcome to Zsh!"
#echo "This computer is"
#figlet `hostname`
neofetch

# amixer set Capture cap > /dev/null 2>&1

export CLICOLOR=1
export TERM=xterm-256color
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/.anyenv/bin:$(yarn global bin):$PATH"
export EDITOR=vim

eval "$(anyenv init -)"

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
#------------- Completion -------------#
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
#---------------- func ----------------#
########################################

function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

function _set_pwd() {
  if grep $TTY ~/.zsh_status ; then
    grep -v $TTY ~/.zsh_status | sed '/^$/d' > ~/.zsh_status_tmp ; mv ~/.zsh_status_tmp ~/.zsh_status
#    sed -i -e 's\^'$TTY'.*$\'$TTY' '`pwd`'\' ~/.zsh_status
  fi
  echo $TTY `pwd` >> ~/.zsh_status
}
add-zsh-hook chpwd _set_pwd

function _zsh_exit() {
  grep -v `tty` ~/.zsh_status | sed '/^$/d' > ~/.zsh_status_tmp ; mv ~/.zsh_status_tmp ~/.zsh_status
}
add-zsh-hook zshexit _zsh_exit


function his() {
  if [ $BUFFER ]; then
    CMD=`history -n 1 | awk '!a[$0]++' | fzf --tac -q $BUFFER`
  else
    CMD=`history -n 1 | awk '!a[$0]++' | fzf --tac`
  fi
  if [ $CMD ]; then
    #BUFFER=$CMD
    echo $CMD
    eval $CMD
    BUFFER=""
    zle reset-prompt
  fi
}

########################################
#---------------- Alias ---------------#
########################################

alias ls='ls -AGFh --color=auto'
alias la='ls -al'
alias g='git add . ; git commit ; git push'
alias pacman='sudo pacman'
alias vi='vim'
alias pbcopy='xsel --clipboard --input'
alias rm='trash-put'
alias rls='gnome-terminal --profile=ls -- ~/.rls.sh $TTY'

########################################
#--------------- Option ---------------#
########################################

setopt print_eight_bit
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd # cd無しでdir移動
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt extended_glob
setopt correct # コマンドミスを指摘
setopt prompt_subst
setopt nonomatch
setopt share_history # 複数端末での履歴を共有

cd ~/working_dir
bindkey -e

bindkey "e[2~" delete-char

zle -N his
bindkey '^H' his
