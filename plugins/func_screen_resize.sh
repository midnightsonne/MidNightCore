#!/usr/bin/env bash

# PLUGIN DESCRIPTION = DETECT THE TERMINAL SIZE AND PRINT AN ERROR IF IT IS TOO SMALL
# HOW TO USE = CALL "get_current_size $1 $2 $3 $4" WHEREVER YOU WANT IN YOUR MAIN SCRIPT

# FLOATING POINT NOT SUPPORTED !

DEF_MIN_WIDTH='100'
DEF_MIN_HEIGHT='25'

# GET CURRENT TERMINAL WINDOW SIZE
function get_current_size() {
  debug_print 2>/dev/null

  read CUR_HEIGHT CUR_WIDTH < <(stty size)

  if [ -z "${CUR_HEIGHT}" ] || [ -z "${CUR_WIDTH}" ]; then
    CUR_HEIGHT=$(tput lines) && CUR_WIDTH=$(tput cols)
  fi

  case "${1,,}" in
    -w)
      MIN_WIDTH=${2}
      case "${3,,}" in
        -h)
          MIN_HEIGHT=${4}
          ;;
        *)
          MIN_HEIGHT=${DEF_MIN_HEIGHT}
          ;;
      esac
      ;;
    -h)
      MIN_HEIGHT=${2}
      case "${3,,}" in
        -w)
          MIN_WIDTH=${4}
          ;;
        *)
          MIN_WIDTH=${DEF_MIN_WIDTH}
          ;;
      esac
      ;;
    *)
      MIN_HEIGHT=${DEF_MIN_HEIGHT}
      MIN_WIDTH=${DEF_MIN_WIDTH}
      ;;
  esac

  ((CUR_WIDTH < MIN_WIDTH | CUR_HEIGHT < MIN_HEIGHT)) && err_resize
}

# PRINT ERROR IF TERMINAL WINDOW IS SMALLER THAN THE SETTED SIZE
function err_resize() {
  clear && debug_print 2>/dev/null

  echo -e "${CLRD}" "\n TERMINAL WINDOW IS TOO SMALL \n" "${CNC}"
  echo -e " CURRENT SIZE: (${CRD}${CUR_WIDTH}${CNC} x ${CRD}${CUR_HEIGHT}${CNC}) "
  echo -en " NEED TO BE ATLEAST: (${CGN}${MIN_WIDTH}${CNC} x ${CGN}${MIN_HEIGHT}${CNC}) "

  sleep .25 && get_current_size -w ${MIN_WIDTH} -h ${MIN_HEIGHT}
}
