OST=""
NST=""

while true
do
  NST=$(grep $1 ~/.zsh_status)
  if [ "$OST" != "$NST" ] ; then
    OST=$NST
    tput reset
    uname -a | grep ARCH > /dev/null && /opt/coreutils/bin/ls -AGFh1 --color=auto $(echo $NST | awk '{print $2}')
    uname -a | grep Darwin > /dev/null && ls -AGFh1 $(echo $NST | awk '{print $2}')
  fi
done
