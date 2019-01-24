#!/bin/node

const execSync = require('child_process').execSync
const exec = require('child_process').exec
const fs = require('fs')

function getPowerAC() {
  const power = fs.readdirSync('/sys/class/power_supply/')
  return power.filter(p => p.match(/AC/))
    .map(p => {
      const ac = fs.readFileSync(`/sys/class/power_supply/${p}/online`, 'utf8');
      return { color: ac == 0 ? "#9999ff" : "#ffff55", full_text: ac == 0 ? "" : ""}
    })
}

function getPowerBattery() {
  const power = fs.readdirSync('/sys/class/power_supply/')
  return power.filter(p => p.match(/BAT/))
    .map(p => {
      const bat = fs.readFileSync(`/sys/class/power_supply/${p}/capacity`, 'utf8').replace(/\n/,"");
      return { color: bat <= 15 ? "#ff3333" : bat <= 50 ? "#ffff55" : "#44ff44", full_text: `${bat}%`}
    })
}

function getDate() {
  const d = new Date()
  return { color: "#ff8833", full_text: `${d.getFullYear()}-${(d.getMonth()+1).toString().padStart(2, "0")}-${d.getDate().toString().padStart(2, "0")} ${d.getHours().toString().padStart(2, "0")}:${d.getMinutes().toString().padStart(2, "0")}:${d.getSeconds().toString().padStart(2, "0")}` }
}

function getMemFree() {
  const free_memory = execSync('free -h | grep Mem | awk \'{print $3"/"$2}\'').toString().replace(/\n/,"")
  return { color: '#999999', full_text: `${free_memory}` }
}

function getSysFree() {
  const system_disk = execSync('mount | grep " / " | awk \'{print $1}\'').toString().replace(/\n/,"")
  const sys_disk_free = execSync(`df -h | grep ${system_disk} | awk \'{print $3"/"$2}\'`).toString().replace(/\n/,"")
  return { color: '#bbbbbb', full_text: `${sys_disk_free}` }
}

function getWifiStatus() {
  const wifi_adapter = execSync('nmcli d')
    .toString()
    .split('\n')
    .filter(w => w.match(/wifi/))
    .map(w => w.split(/\s+/)[0])[0]
  return execSync(`nmcli d show ${wifi_adapter}`).toString().split(/\n/)
}

let prevIP = ''
let gIP = ''
function getGlobalIP() {
  if(prevIP != ip) {
    gIP = execSync('curl -s ifconfig.me -m 1').toString().replace(/\n/,"")
    prevIP = ip
  }
  if(gIP == '') return null
  return { color: '#55CCFF', full_text: `${gIP}` }
}

let ip = ''
function getIPv4(stat) {
  const ipv4_raw = stat.filter(s => s.match(/IP4.ADDRESS\[1\]/))[0]
  if(!ipv4_raw) return null
  const ipv4 = ipv4_raw.split(/\s+/)[1]
  ip = ipv4
  return { color: '#55FFCC', full_text: `${ipv4}` }
}

function getIPv6(stat) {
  const ipv6_raw = stat.filter(s => s.match(/IP6.ADDRESS\[1\]/))[0]
    if(!ipv6_raw) return null
  const ipv6 = ipv6_raw.split(/\s+/)[1]
  return { color: '#CCCCFF', full_text: `${ipv6}` }
}

function getSSID(stat) {
  const status = stat.filter(s => s.match(/GENERAL.STATE/))[0].split(/\s+/)[1]
  const connection = stat.filter(s => s.match(/GENERAL.CONNECTION/))[0].split(/\s+/)[1]

  let wifi = {}
  switch(status) {
    case '20':
      wifi = { color: '#ff3333', full_text: 'Disabled' }
      break
    case '30':
      wifi = { color: '#ff7722', full_text: 'Disconnected' }
      break
    case '50':
      wifi = { color: '#FFFF00', full_text: 'Connecting' }
      break
    case '100':
      const ssid = stat.filter(s => s.match(/GENERAL.CONNECTION/))[0].split(/\s+/)[1]
      wifi = { color: '#44FF44', full_text: `${ssid}` }
      break
    default:
      wifi = { color: '#4444FF', full_text: 'Unknown' }
      break
  }
  return wifi
}

function getVolume() {
  let volume = execSync(`pactl list sinks | sed -e 's/\t//g' | grep Volume | grep front-left | awk '{print $5}'`).toString().replace(/\n/,"")
  const isMute = execSync(`pactl list sinks | sed -e 's/\t//g' | grep 'Mute'`).toString().indexOf('yes') > -1
  return { color: isMute ? '#ff3333' : '#9999ff', full_text: `${isMute ? 'M' : volume}` }
}

function getRx() {
  let data = []
  try {
    data = fs.readFileSync(`${require('os').homedir()}/.speed`, 'utf8')
      .split('[2K')
      .filter(l => l.indexOf('rx') > -1)[0]
      .split(/\s+/)
  } catch(e) {}

  if(data.length == 0) return null
  return { color: '#ff9999', full_text: `${data[2]}${data[3]}` }
}

function getTx() {
  let data = []
  try {
    data = fs.readFileSync(`${require('os').homedir()}/.speed`, 'utf8')
      .split('[2K')
      .filter(l => l.indexOf('rx') > -1)[0]
      .split(/\s+/)
  } catch(e) {}

  if(data.length == 0) return null
  return { color: '#9999ff', full_text: `${data[7]}${data[8]}` }
}

exec(`vnstat -l -i $(nmcli d | grep wifi | awk '{print $1}') > ~/.speed&`)

console.log('{"version":1}')
console.log('[')

function main() {
  const wifi = getWifiStatus()

  const body = [
    getGlobalIP(),
    getIPv6(wifi),
    getIPv4(wifi),
    getSSID(wifi),
    getRx(),
    getTx(),
    getSysFree(),
    getMemFree(),
    ...getPowerAC(),
    ...getPowerBattery(),
    getDate(),
    getVolume()
  ]

  console.log(JSON.stringify(body) + ',')

  setTimeout(main, 100)
}
setTimeout(main, 100)

function battery() {
  const power = fs.readdirSync('/sys/class/power_supply/')
  const ac = power.filter(p => p.match(/AC/))
    .map(p => {
      const ac = fs.readFileSync(`/sys/class/power_supply/${p}/online`, 'utf8');
      return ac == 1
    })[0]
  const bat = power.filter(p => p.match(/BAT/))
    .map(p => {
      const bat = fs.readFileSync(`/sys/class/power_supply/${p}/capacity`, 'utf8').replace(/\n/,"");
      return bat
    })
    .every(p => p <= 20)

  if(!ac && bat)
    execSync('amixer set Capture toggle')
  else
    execSync('amixer set Capture cap')

  setTimeout(battery, 200)
}
setTimeout(battery, 200)
