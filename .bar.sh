echo '{"version":1}'
echo "["
sh ~/.battery.sh &
while true
do
# cat /sys/class/power_supply/BAT1/capacity

  bat_st_raw=`acpi | sed -e 's/,//g' | awk '{print $3}'`
  bat_pr_raw_1=`cat /sys/class/power_supply/BAT0/capacity`
  bat_pr_raw_2=`cat /sys/class/power_supply/BAT1/capacity`
  bat_raw_1=`acpi | grep "Battery 0"`
  bat_raw_2=`acpi | grep "Battery 1"`

  remain=`acpi | awk '{print $5}' | sed '/^$/d'`

  ac_st=`cat /sys/class/power_supply/AC/online`

  if [ $ac_st -eq 0 ] ; then
    ac='{"color":"#9999ff","markup":"none","full_text":""},'
  else
    ac='{"color":"#ffff55","markup":"none","full_text":""},'
  fi

  if [ -e /sys/class/power_supply/BAT0/capacity ] ; then
    b=`cat /sys/class/power_supply/BAT0/capacity`
    if [ $b -le 15 ] ; then
      bat_pr_1='{"color":"#FF3333","markup":"none","full_text":"'$b%'"},'
    elif [ $b -le 50 ]; then
      bat_pr_1='{"color":"#FFFF55","markup":"none","full_text":"'$b%'"},'
    else
      bat_pr_1='{"color":"#44FF44","markup":"none","full_text":"'$b%'"},'
    fi
  else
    bat_pr_1=''
  fi

  if [ -e /sys/class/power_supply/BAT1/capacity ] ; then
    b=`cat /sys/class/power_supply/BAT1/capacity`
    if [ $b -le 15 ] ; then
      bat_pr_2='{"color":"#FF3333","markup":"none","full_text":"'$b%'"},'
    elif [ $b -le 50 ]; then
      bat_pr_2='{"color":"#FFFF55","markup":"none","full_text":"'$b%'"},'
    else
      bat_pr_2='{"color":"#44FF44","markup":"none","full_text":"'$b%'"},'
    fi
  else
    bat_pr_2=''
  fi

  date='{"color":"#ff8833","markup":"none","full_text":"'`date +%Y-%m-%d\ %H:%M:%S`'"},'

  wifi_raw="$(nmcli d show wlp3s0)"

  if $(nmcli d show wlp3s0 | grep "GENERAL.STATE" | grep "20" > /dev/null) ; then
    wifi='{"color":"#FF3333","markup":"none","full_text":"Disabled"},'
  elif $(nmcli d show wlp3s0 | grep "GENERAL.STATE" | grep "30" > /dev/null) ; then
    wifi='{"color":"#FF7722","markup":"none","full_text":"Disconnected"},'
  elif $(nmcli d show wlp3s0 | grep "GENERAL.STATE" | grep "50" > /dev/null) ; then
    wifi='{"color":"#FFFF00","markup":"none","full_text":"Connecting"},'
  elif $(nmcli d show wlp3s0 | grep "GENERAL.STATE" | grep "100" > /dev/null) ; then
    ssid=`nmcli d show wlp3s0 | grep "GENERAL.CONNECTION" | awk -F ":" '{print $2}' | sed -e 's/^[ ]*//g'`
    wifi='{"color":"#44FF44","markup":"none","full_text":"'$ssid'"},'
  fi

  l=`nmcli d show wlp3s0 | grep "IP4.ADDRESS" | awk -F ":" '{print $2}' | sed -e 's/^[ ]*//g'`
  if [ "$LocalIP" != "$l" ]; then
    LocalIP=$l
    GlobalIP=`curl ifconfig.io -m 1`
  fi

  if [ ! $GlobalIP ] ; then
    GlobalIP=`curl ifconfig.io -m 1`
  fi

  if [ $LocalIP ]; then
    lip='{"color":"#55FFCC","markup":"none","full_text":"'$LocalIP'"},'
  else
    lip=""
  fi
  if [ $GlobalIP ]; then
    gip='{"color":"#55CCFF","markup":"none","full_text":"'$GlobalIP'"},'
  else
    gip=""
  fi

  vol='{"color":"#9999ff","markup":"none","full_text":"'$(pactl list sinks | sed -e 's/\t//g' | grep Volume | grep front-left | awk '{print $5}')'"}'

  if $(pactl list sinks | sed -e 's/\t//g' | grep 'Mute: yes' > /dev/null) ; then
    vol='{"color":"#FF3333","markup":"none","full_text":"M"}'
  fi

  mem='{"color":"#999999","markup":"none","full_text":"'`free -h | grep Mem | awk '{print $3"/"$2}'`'"},'
  rom='{"color":"#bbbbbb","markup":"none","full_text":"'`df -h | grep "sda9" | awk '{print $3"/"$2}'`'"},'

  speed_tmp=`cat ~/.speed -A | sed -e 's/\^\[\[1G\^\[\[2K/\n/g' | sed -e 's/\^\@//g' | grep rx | tac | sed -n '1p' | grep rx`
  if [ $? -eq 0 ]; then
    speed=$speed_tmp
    echo "" > ~/.speed
  fi

  tx='{"color":"#ff9999","markup":"none","full_text":"'`echo $speed | awk '{print $7" "$8}'`'"},'
  rx='{"color":"#9999ff","markup":"none","full_text":"'`echo $speed | awk '{print $2" "$3}'`'"},'

  echo "[$gip$lip$wifi$tx$rx$rom$mem$ac$bat_pr_1$bat_pr_2$date$vol],"
done
