#!/usr/bin/env bash

# PLUGIN DESCRIPTION = DETECT SCREEN RESOLUTION AND SET -geometry FOR XTERM
# HOW TO USE = CALL "check_screenres" WHEREVER YOU WANT IN YOUR MAIN SCRIPT

XRATIO="6.2"
YRATIO="13.9"
YWINDOW="2"

# DETECT SCREEN RESOLUTION
function check_screenres() {
  debug_print 2>/dev/null

  if RESOLUTION=$(xdpyinfo 2>/dev/null | grep -A 3 "screen #0" | grep "dimensions" | tr -s " " | cut -d " " -f 3 | grep "x"); then
    RESOLUTION=${RESOLUTION}
  else
    RESOLUTION="1024x768"
  fi

  [[ ${RESOLUTION} =~ ^([0-9]{3,4})x([0-9]{3,4})$ ]] && RESOLUTION_X="${BASH_REMATCH[1]}" && RESOLUTION_Y="${BASH_REMATCH[2]}"

  set_xsizes && set_ysizes

  TOPLEFT_WINDOW="${XWINDOW}x${YWINDOWHALF}+0+0"
  BOTTOMLEFT_WINDOW="${XWINDOW}x${YWINDOWHALF}+0-0"
  TOPRIGHT_WINDOW="${XWINDOW}x${YWINDOWHALF}-0+0"
  BOTTOMRIGHT_WINDOW="${XWINDOW}x${YWINDOWHALF}-0-0"
}

# SET SIZES FOR X AXIS
function set_xsizes() {
  debug_print 2>/dev/null

  XTOTAL=$(awk -v n1="${RESOLUTION_X}" "BEGIN{print n1 / ${XRATIO}}")

  if ! XTOTALTMP=$(printf "%.0f" "${XTOTAL}" 2>/dev/null); then
    DEC_CHAR=","
    XTOTAL="${XTOTAL/./${DEC_CHAR}}"
    XTOTAL=$(printf "%.0f" "${XTOTAL}" 2>/dev/null)
  else
    XTOTAL=${XTOTALTMP}
  fi

  XCENTRAL_SPACE=$((XTOTAL * 5 / 100))
  XHALF=$((XTOTAL / 2))
  XWINDOW=$((XHALF - XCENTRAL_SPACE))
}

# SET SIZES FOR Y AXIS
function set_ysizes() {
  debug_print 2>/dev/null

  YTOTAL=$(awk -v n1="${RESOLUTION_Y}" "BEGIN{print n1 / ${YRATIO}}")

  if ! YTOTALTMP=$(printf "%.0f" "${YTOTAL}" 2>/dev/null); then
    DEC_CHAR=","
    YTOTAL="${YTOTAL/./${DEC_CHAR}}"
    YTOTAL=$(printf "%.0f" "${YTOTAL}" 2>/dev/null)
  else
    YTOTAL=${YTOTALTMP}
  fi

  YWINDOWHALF=$((YTOTAL / 2 - YWINDOW))
}
