#!/usr/bin/env bash

# CHECK IF USER HAS ROOT PERMISSIONS
function check_root() {
  debug_print 2>/dev/null

  if [ ${EUID} = "0" ]; then
    UH_ROOT="TRUE"

    if [ "${1,,}" = "quiet" ] || [ "${2,,}" = "quiet" ]; then
      return
    else
      echo -e " ${CGMRK} - USER WITH ROOT PERMISSIONS " "${CNC}"
    fi
  else
    if [ "${1,,}" = "quit" ] || [ "${2,,}" = "quit" ]; then
      echo -e " ${CBMRK} - USER WITHOUT ROOT PERMISSIONS " "${CNC}" && exit
    else
      echo -e " ${CBMRK} - USER WITHOUT ROOT PERMISSIONS " "${CNC}"
    fi
  fi
}

# CHECK IF USER HAS THE "MINIMUM REQUIRED BASH VERSION"
function check_bash() {
  debug_print 2>/dev/null

  BASH_MVERSION="${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}"

  if funcCompare 1 "${BASH_MVERSION}" "4.4"; then
    UH_MINBASHV="TRUE"

    if [ "${1,,}" = "quiet" ] || [ "${2,,}" = "quiet" ]; then
      return
    else
      echo -e " ${CGMRK} - USER WITH ACCEPTABLE BASH VERSION " "${CNC}"
    fi
  else
    if [ "${1,,}" = "quit" ] || [ "${2,,}" = "quit" ]; then
      echo -e " ${CBMRK} - USER WITHOUT ACCEPTABLE BASH VERSION ( ${BASH_MVERSION} ) "
      echo -e " ${CAMRK} - MINIMUM REQUIRED BASH VERSION: ${MIN_BASHVERSION} " "${CNC}" && exit
    else
      echo -e " ${CBMRK} - USER WITHOUT ACCEPTABLE BASH VERSION ( ${BASH_MVERSION} ) "
      echo -e " ${CAMRK} - MINIMUM REQUIRED BASH VERSION: ${MIN_BASHVERSION} " "${CNC}"
    fi
  fi
}

# CHECK IF USER HAS CAPSLOCK ENABLED OR DISABLED
function check_caps() {
  debug_print 2>/dev/null

  CAPS=$(xset -q | grep Caps | cut -c 22-24)

  if [ "${CAPS}" != "off" ] && [ "${1,,}" = "off" ]; then
    echo -e " ${CBMRK} - USER WITH CAPSLOCK ON " "${CNC}" && exit
  elif [ "${CAPS}" != "off" ]; then
    echo -e " ${CAMRK} - USER WITH CAPSLOCK ON " "${CNC}"
  elif [ "${CAPS}" != "on" ] && [ "${1,,}" = "on" ]; then
    echo -e " ${CBMRK} - USER WITH CAPSLOCK OFF " "${CNC}" && exit
  elif [ "${CAPS}" != "on" ]; then
    echo -e " ${CAMRK} - USER WITH CAPSLOCK OFF " "${CNC}"
  fi
}

# CHECK IF USER HAS INTERNET CONNECTION
function check_conn() {
  debug_print 2>/dev/null
  if (ping -c 1 google.com >/dev/null 2>&1); then
    UH_CONNECTED="TRUE"

    [ "${1,,}" != "var" ] && echo -e " ${CAMRK} - USER WITH INTERNET CONNECTION " "${CNC}"
  else
    [ "${1,,}" != "var" ] && echo -e " ${CAMRK} - USER WITHOUT INTERNET CONNECTION " "${CNC}"
  fi
}

# INSTALL MISSING REQUIRED PACKAGES
function install_pkgs() {
  debug_print 2>/dev/null
  for ESSENTIAL_PKGS in "${ESSENTIAL_PKGS[@]}"; do
    if [ "$(dpkg-query -W -f='${Status}' "${ESSENTIAL_PKGS}" | grep -c "ok installed")" -eq 0 ]; then
      sudo apt-get -y install "${ESSENTIAL_PKGS}"
    fi >/dev/null
  done
}

# CHECK IF USER HAS REQUIRED PACKAGES
function check_pkgs() {
  debug_print 2>/dev/null && MISSING_PKGS="0"
  for ESSENTIAL_PKGS in "${ESSENTIAL_PKGS[@]}"; do
    if [ "$(dpkg-query -W -f='${Status}' "${ESSENTIAL_PKGS}" | grep -c "ok installed")" -eq 0 ]; then
      MISSING_PKGS=$((MISSING_PKGS = MISSING_PKGS + 1))
    fi >/dev/null
  done

  [ "${MISSING_PKGS}" -ge "1" ] && echo -e " ${CBMRK} - USER WITHOUT SOME REQUIRED PACKAGES (${MISSING_PKGS}) " "${CNC}"
}

# INSTALL NEWEST SCRIPT VERSION
function install_vrsn() {
  check_conn var
  if [ "${UH_CONNECTED}" = "TRUE" ]; then
    echo -en "\n PLEASE WAIT A SECOND ... " && sleep 1
    if [ "${UH_OLDVRSN}" = "TRUE" ]; then
      sudo apt-get -y install git >/dev/null 2>&1 && sudo mkdir "/tmp/${SCRIPTNAME}/"
      cat >"/tmp/${SCRIPTNAME}/Update.sh" <<-EOF
				sudo git clone -q "https://github.com/midnightsonne/${SCRIPTNAME}.git" "/tmp/${SCRIPTNAME}/New/"
				cd "/tmp/${SCRIPTNAME}/New/" && sudo bash install.sh -i >/dev/null
			EOF
      sudo bash "/tmp/${SCRIPTNAME}/Update.sh" && sudo rm -r "/tmp/${SCRIPTNAME}/"
    fi && echo -e "\r ${CGMRK} - USER WITH SCRIPT LATEST VERSION ! " "${CNC}" && exit
  else
    echo -e " ${CBMRK} - USER WITHOUT INTERNET CONNECTION " "${CNC}"
  fi
}

# COMPARE SCRIPT VERSION
function check_vrsn() {
  debug_print 2>/dev/null
  if funcCompare 1 "${LASTVERSION}" "${SCRIPTVERSION}"; then
    UH_OLDVRSN="TRUE" && echo -e " ${CAMRK} - NEW \"${SCRIPTNAME}\" VERSION AVAILABLE " "${CNC}"
  fi
}
