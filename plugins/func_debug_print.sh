#!/usr/bin/env bash

# PLUGIN DESCRIPTION = SHOW FROM WHERE A FUNCTION IS BEING CALLED
# HOW TO USE = CALL "debug_print" FROM THE START OF A FUNCTION (USUALLY IN THE FIRST FEW LINES)

# PRINT THE CURRENT LINE OF WHEREVER IT WAS CALLED AND THE FUNCTION NAME
function debug_print() {
  if [ "${DEBUG_MODE}" = "MINIMAL" ] || [ "${DEBUG_MODE}" = "MIN" ]; then
    echo -e "${CNC}${CAMRK}" "SOURCE:${CNC}${BASH_SOURCE[1]}" "${CBE}" "FUNCTION:${CNC}${FUNCNAME[1]}" "${CBE}" "LINE:${CNC}${BASH_LINENO[1]}"
  elif [ "${DEBUG_MODE}" = "TRUE" ]; then
    echo -e "${CNC}${CAMRK}" "SOURCE:${CNC}${BASH_SOURCE[1]}"
    echo -e "${CNC}${CAMRK}" "FUNCTION:${CNC}${FUNCNAME[1]}"
    echo -e "${CNC}${CAMRK}" "LINE:${CNC}${BASH_LINENO[1]}"
  fi
}
