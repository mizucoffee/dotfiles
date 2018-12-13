#!/bin/bash
vnstat -l -i wlp2s0 > ~/.speed&
while true
do
  if [ `cat /sys/class/power_supply/AC/online` -eq 0 -a `cat /sys/class/power_supply/BAT0/capacity` -le 20 ] ; then
    amixer set Capture toggle > /dev/null 2>&1
  else
    amixer set Capture cap > /dev/null 2>&1
  fi
  sleep 0.2
done
