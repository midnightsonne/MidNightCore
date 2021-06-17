#!/usr/bin/env bash

# PLUGIN DESCRIPTION = GET AND PRINT COMMON NETWORK SETTINGS
# HOW TO USE = CALL "iface_selection" WHEREVER YOU WANT IN YOUR MAIN SCRIPT (NEEDED TO SELECT A INTERFACE).

# INTERFACE SELECTION
function iface_selection() {
  debug_print 2>/dev/null && OPT_C1=0 && OPT_C2=0

  IFACES=$(ip link | grep -E "^[0-9]+" | cut -d ':' -f 2 | awk '{print $1}' | grep -E "^lo$" -v)

  echo -e "${CLBE}" "\n INTERFACE SELECTION \n"
  for I1 in ${IFACES}; do
    OPT_C1=$((OPT_C1 + 1)) && echo -e " ${CLR_SEPARATORS[0]}${OPT_C1}${CLR_SEPARATORS[1]} ${CLR_SEPARATORS[2]} ${I1} "
  done
  echo -e "\n ${CLR_SEPARATORS[0]}0${CLR_SEPARATORS[1]} ${CLR_SEPARATORS[2]} BACK "
  echo -en "\n ${CGN} > " && read -r READ_IFACE

  [ "${READ_IFACE}" = "0" ] && return

  if [[ ! ${READ_IFACE} =~ ^[[:digit:]]+$ ]] || ((READ_IFACE < 1 || READ_IFACE > OPT_C1)); then
    clear && iface_selection
  else
    for I2 in ${IFACES}; do
      OPT_C2=$((OPT_C2 + 1)) && [[ ${READ_IFACE} == "${OPT_C2}" ]] && INTERFACE=${I2}
    done
  fi
}

# FETCHES CURRENT WAN IP ADDRESS
function wan_search() {
  debug_print 2>/dev/null
  WAN=$(curl "https://api.ipify.org" 2>/dev/null)
}

# FETCHES CURRENT LAN IP ADDRESS
function lan_search() {
  debug_print 2>/dev/null
  LAN=$(ip addr show | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -v "${WAN}")
}

# FETCHES CURRENT ROUTER IP ADDRESS
function router_search() {
  debug_print 2>/dev/null
  ip route | grep "default via" | head -1 | awk '{print$3}'
}

# FETCHES CURRENT DNS NAMESERVER
function dns_search() {
  debug_print 2>/dev/null
  cat "/etc/resolv.conf" | grep -i ^nameserver | cut -d ' ' -f2
}

# FETCHES CURRENT MAC ADDRESS
function mac_search() {
  debug_print 2>/dev/null
  ip addr show "${INTERFACE}" | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | grep -v ff:
}

# FETCHES CURRENT GEODATA BASED ON IP
function geodata_search() {
  debug_print 2>/dev/null
  curl "http://ip-api.com/line/?fields=query,city,region,country,zip,isp" 2>/dev/null
}
