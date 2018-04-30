OST=""
NST=""

while true
do
  NST=$(grep $1 ~/.zsh_status)
  if [ "$OST" != "$NST" ] ; then
    OST=$NST
    reset
    ls -AGFh1 --color=auto $(echo $NST | awk '{print $2}')
  fi
  #sleep 1
done
