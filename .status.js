#!/bin/node

const execSync = require('child_process').execSync;
const fs = require('fs');

console.log('{"version":1}')
console.log('[')

while (true) {
  const power = fs.readdirSync('/sys/class/power_supply/')

  const power_ac = power.filter(p => p.match(/AC/))
    .map(p => {
      const ac = fs.readFileSync(`/sys/class/power_supply/${p}/online`, 'utf8');
      return {
        color: ac == 0 ? "#9999ff" : "#ffff55",
        full_text: ac == 0 ? "" : ""
      }
    })

  const power_bat = power.filter(p => p.match(/BAT/))
    .map(p => {
      const bat = fs.readFileSync(`/sys/class/power_supply/${p}/capacity`, 'utf8').replace(/\n/,"");
      return {
        color: bat <= 15 ? "#ff3333" : bat <= 50 ? "#ffff55" : "#44ff44",
        full_text: `${bat}%`
      }
    })

  const d = new Date()
  const date = { color: "#ff8833", full_text: `${d.getFullYear()}-${(d.getMonth()+1).toString().padStart(2, "0")}-${d.getDate().toString().padStart(2, "0")} ${d.getHours().toString().padStart(2, "0")}:${d.getMinutes().toString().padStart(2, "0")}:${d.getSeconds().toString().padStart(2, "0")}` }

  const wifi = execSync('nmcli d')
    .toString()
    .split('\n')
    .filter(w => w.match(/wifi/))
    .reduce((list, w) => {
      const stat = execSync(`nmcli d show ${w.split(/\s+/)[0]}`).toString().split(/\n/)
      const ipv4 = stat.filter(s => s.match(/IP4.ADDRESS\[1\]/))[0]
      const ipv6 = stat.filter(s => s.match(/IP6.ADDRESS\[1\]/))[0]
      const status = stat.filter(s => s.match(/GENERAL.STATE/))[0]
      
      return list
    },[])

  const body = [...power_ac, ...power_bat, date]

  console.log(JSON.stringify(body) + ',')
  // console.log(new Date().toJSON())
}